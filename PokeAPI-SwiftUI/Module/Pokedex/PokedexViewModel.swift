//
//  PokedexViewModel.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 10/08/25.
//

import Combine
import Foundation

class PokedexViewModel: ObservableObject {
    
    @Published var pokemons: [Pokedex.Result] = []
    @Published var errorMessage: String = ""
    private var cancellables: Set<AnyCancellable> = []
    private let apiService: APIServiceProtocol
    private let limit = 24
    private var offset = 0
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        self.fetchPokedex()
    }
    
    func fetchPokedex() {
        let pokedex = RealmService.shared.getPokedex(limit: limit, offset: offset)
        if pokedex.isEmpty {
            let parameters: [String: Any] = [
                "limit": limit,
                "offset": offset
            ]
            apiService.fetchPokedex(endPoint: .pokemon, method: .get, parameters: parameters)
                .receive(on: DispatchQueue.main)
                .sink { [weak self] result in
                    guard let `self` = self else { return }
                    if case .failure(let error) = result {
                        self.errorMessage = error.localizedDescription
                    }
                } receiveValue: { [weak self] result in
                    guard let `self` = self else { return }
                    self.pokemons.append(contentsOf: result.results)
                    self.offset += self.limit
                    let pokemonEntities = result.results.map { result in
                        let entity = PokemonEntity()
                        entity.idPokemon = Int(result.id ?? "") ?? 0
                        entity.name = result.name
                        entity.url = result.url
                        return entity
                    }
                    RealmService.shared.storePokedex(pokemonEntities)
                }
                .store(in: &cancellables)
        } else {
            let localPokemon = pokedex.map { result in
                let entity = Pokedex.Result(from: result)
                return entity
            }
            self.offset += self.limit
            self.pokemons.append(contentsOf: localPokemon)
        }
    }
}
