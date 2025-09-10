//
//  MockData.swift
//  PokeAPI-SwiftUITests
//
//  Created by alif rama on 08/08/25.
//

import Foundation
import Combine
import Alamofire
@testable import PokeAPI_SwiftUI

struct MockData {
    
    static let samplePokedexResponse = Pokedex.Response(
        count: 1154,
        next: "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
        previous: nil,
        results: [
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/1/", name: "bulbasaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/2/", name: "ivysaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/3/", name: "venusaur")
        ]
    )
    
    static let samplePokemonResponse = Pokemon.Response(
        id: 25,
        name: "pikachu",
        abilities: [
            Pokemon.Ability(
                ability: Pokemon.AbilityInfo(name: "static", detailURL: "https://pokeapi.co/api/v2/ability/9/"),
                isHidden: false,
                slot: 1
            )
        ],
        sprites: Pokemon.Sprites(
            other: Pokemon.SpritesOther(
                officialArtwork: Pokemon.OfficialArtwork(
                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
                )
            )
        ),
        types: [
            Pokemon.Types(
                slot: 1,
                type: Pokemon.TypesInfo(name: "electric", url: "https://pokeapi.co/api/v2/type/13/")
            )
        ],
        stats: [
            Pokemon.Stats(
                baseStat: 35,
                effort: 0,
                stat: Pokemon.StatsInfo(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
            ),
            Pokemon.Stats(
                baseStat: 55,
                effort: 0,
                stat: Pokemon.StatsInfo(name: "attack", url: "https://pokeapi.co/api/v2/stat/2/")
            )
        ],
        height: 4.0,
        weight: 60.0
    )
    
    static let samplePokemonSpeciesResponse = PokemonSpecies.Response(
        flavorTextEntries: [
            PokemonSpecies.FlavourTextEntry(
                flavourText: "When several of these POKéMON gather, their electricity could build and cause lightning storms."
            )
        ]
    )
    
    static let samplePokemonEntities: [PokemonEntity] = {
        let entity1 = PokemonEntity()
        entity1.idPokemon = 1
        entity1.name = "bulbasaur"
        entity1.url = "https://pokeapi.co/api/v2/pokemon/1/"
        
        let entity2 = PokemonEntity()
        entity2.idPokemon = 2
        entity2.name = "ivysaur"
        entity2.url = "https://pokeapi.co/api/v2/pokemon/2/"
        
        return [entity1, entity2]
    }()
}

// Mock API Service for testing
class MockAPIService: APIServiceProtocol {
    var shouldReturnError = false
    var errorToReturn: AFError?
    
    func fetchPokedex(endPoint: APIService.EndPoint, method: HTTPMethod, parameters: Parameters?) -> AnyPublisher<Pokedex.Response, AFError> {
        if shouldReturnError {
            return Fail(error: errorToReturn ?? AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 500)))
                .eraseToAnyPublisher()
        }
        
        return Just(MockData.samplePokedexResponse)
            .setFailureType(to: AFError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchPokemon(endPoint: APIService.EndPoint, path: [String], method: HTTPMethod, parameters: Parameters?) -> AnyPublisher<Pokemon.Response, AFError> {
        if shouldReturnError {
            return Fail(error: errorToReturn ?? AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 500)))
                .eraseToAnyPublisher()
        }
        
        return Just(MockData.samplePokemonResponse)
            .setFailureType(to: AFError.self)
            .eraseToAnyPublisher()
    }
    
    func fetchPokemonSpecies(endPoint: APIService.EndPoint, path: [String], method: HTTPMethod, parameters: Parameters?) -> AnyPublisher<PokemonSpecies.Response, AFError> {
        if shouldReturnError {
            return Fail(error: errorToReturn ?? AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: 500)))
                .eraseToAnyPublisher()
        }
        
        return Just(MockData.samplePokemonSpeciesResponse)
            .setFailureType(to: AFError.self)
            .eraseToAnyPublisher()
    }
}

// Mock Realm Service for testing
class MockRealmService {
    var storedPokedex: [PokemonEntity] = []
    var storedPokemon: [String: PokemonDetailEntity] = [:]
    var storedSpecies: [String: PokemonSpeciesEntity] = [:]
    
    func getPokedex(limit: Int, offset: Int = 0) -> [PokemonEntity] {
        return Array(storedPokedex.dropFirst(offset).prefix(limit))
    }
    
    func getPokemon(withName: String) -> PokemonDetailEntity? {
        return storedPokemon[withName]
    }
    
    func getPokemonSpecies(withName: String) -> PokemonSpeciesEntity? {
        return storedSpecies[withName]
    }
    
    func storePokedex(_ pokemon: [PokemonEntity]) {
        storedPokedex.append(contentsOf: pokemon)
    }
    
    func storePokemon(id: Int, name: String, abilities: [Pokemon.Ability], spritesOther: Pokemon.Sprites, types: [Pokemon.Types], weight: Double, height: Double, stats: [Pokemon.Stats]) {
        // Create mock PokemonDetailEntity
        let entity = PokemonDetailEntity()
        entity.idPokemon = id
        entity.name = name
        entity.height = height
        entity.weight = weight
        storedPokemon[name] = entity
    }
    
    func storePokemonSpecies(flavourTextEntries: [PokemonSpecies.FlavourTextEntry]) {
        // Create mock PokemonSpeciesEntity
        let entity = PokemonSpeciesEntity()
        entity.name = "test"
        storedSpecies["test"] = entity
    }
}

// Note: Removed the apply extension as it's not compatible with Realm objects
// Realm objects have specific initialization and property setting requirements
