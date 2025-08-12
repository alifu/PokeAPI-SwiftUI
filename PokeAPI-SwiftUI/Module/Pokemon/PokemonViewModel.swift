//
//  PokemonViewModel.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 12/08/25.
//

import Combine
import Foundation

class PokemonViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    @Published var id: Int = 0
    @Published var name: String?
    @Published var abilities: [String] = []
    @Published var height: Double?
    @Published var weight: Double?
    @Published var stats: [Pokemon.Stats] = []
    @Published var imageURL: String = ""
    @Published var types: [String] = []
    @Published var about: String = ""
    private var cancellables: Set<AnyCancellable> = []
    private let apiService: APIServiceProtocol
    private let limit = 24
    private var offset = 0
    
    init(apiService: APIServiceProtocol = APIService(), name: String) {
        self.apiService = apiService
        self.name = name
        self.fetchPokemons()
        self.fetchPokemonSpecies()
    }
    
    func fetchPokemons() {
        guard let `name` = name else { return }
        if let pokemon = RealmService.shared.getPokemon(withName: name) {
            self.abilities = Array(pokemon.abilities.map {
                String($0.name)
            })
            self.imageURL = pokemon.spritesOther?.officialArtwork ?? ""
            self.stats = Array(pokemon.stats.map { result in
                Pokemon.Stats(
                    baseStat: result.baseStat,
                    effort: result.effort,
                    stat: Pokemon.StatsInfo(name: result.stat, url: "")
                )
            })
            self.types = Array(pokemon.types.map { result in
                String(result.type)
            })
            self.height = pokemon.height
            self.weight = pokemon.weight
            self.name = pokemon.name
            self.id = Int(pokemon.idPokemon)
        } else {
            apiService.fetchPokemon(endPoint: .pokemon, path: [name], method: .get, parameters: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] result in
                    guard let `self` = self else { return }
                    if case .failure(let error) = result {
                        self.errorMessage = error.localizedDescription
                    }
                } receiveValue: { [weak self] result in
                    guard let `self` = self else { return }
                    let abilities = result.abilities
                    let sprites = result.sprites
                    let stats = result.stats
                    let types = result.types
                    let height = result.height
                    let weight = result.weight
                    let name = result.name
                    let id = result.id
                    
                    self.abilities = abilities.map { $0.ability.name }
                    self.imageURL = sprites.other.officialArtwork.frontDefault
                    self.stats = stats
                    self.types = types.map { $0.type.name }
                    self.height = Double(height)
                    self.weight = Double(weight)
                    self.name = name
                    self.id = id
                    
                    RealmService.shared.storePokemon(
                        id: id,
                        name: name,
                        abilities: abilities,
                        spritesOther: sprites,
                        types: types,
                        weight: weight,
                        height: height,
                        stats: stats
                    )
                }
                .store(in: &cancellables)
        }
    }
    
    func fetchPokemonSpecies() {
        guard let `name` = name else { return }
        if let pokemon = RealmService.shared.getPokemonSpecies(withName: name) {
            self.about = pokemon.flavourTextEntries.first?.flavourText ?? ""
        } else {
            apiService.fetchPokemonSpecies(endPoint: .pokemonSpecies, path: [name], method: .get, parameters: nil)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] result in
                    guard let `self` = self else { return }
                    if case .failure(let error) = result {
                        self.errorMessage = error.localizedDescription
                    }
                } receiveValue: { [weak self] result in
                    guard let `self` = self else { return }
                    let about = result.flavorTextEntries.first?.flavourText ?? ""
                    
                    self.about = about.replacingOccurrences(of: "\n", with: " ")
                    
                    RealmService.shared.storePokemonSpecies(flavourTextEntries: result.flavorTextEntries)
                }
                .store(in: &cancellables)
        }
    }
}
