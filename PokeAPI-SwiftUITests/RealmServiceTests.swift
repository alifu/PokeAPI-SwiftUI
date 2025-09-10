//
//  RealmServiceTests.swift
//  PokeAPI-SwiftUITests
//
//  Created by alif rama on 08/08/25.
//

import XCTest
@testable import PokeAPI_SwiftUI

final class RealmServiceTests: XCTestCase {
    
    var mockRealmService: MockRealmService!
    
    override func setUp() {
        super.setUp()
        mockRealmService = MockRealmService()
    }
    
    override func tearDown() {
        mockRealmService = nil
        super.tearDown()
    }
    
    func testMockRealmServiceInitialization() {
        // Given & When & Then
        XCTAssertNotNil(mockRealmService)
        XCTAssertTrue(mockRealmService.storedPokedex.isEmpty)
        XCTAssertTrue(mockRealmService.storedPokemon.isEmpty)
        XCTAssertTrue(mockRealmService.storedSpecies.isEmpty)
    }
    
    func testStorePokedex() {
        // Given
        let pokemonEntities = MockData.samplePokemonEntities
        
        // When
        mockRealmService.storePokedex(pokemonEntities)
        
        // Then
        XCTAssertEqual(mockRealmService.storedPokedex.count, 2)
        XCTAssertEqual(mockRealmService.storedPokedex[0].name, "bulbasaur")
        XCTAssertEqual(mockRealmService.storedPokedex[1].name, "ivysaur")
    }
    
    func testGetPokedexWithLimit() {
        // Given
        let pokemonEntities = MockData.samplePokemonEntities
        mockRealmService.storePokedex(pokemonEntities)
        
        // When
        let result = mockRealmService.getPokedex(limit: 1)
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].name, "bulbasaur")
    }
    
    func testGetPokedexWithOffset() {
        // Given
        let pokemonEntities = MockData.samplePokemonEntities
        mockRealmService.storePokedex(pokemonEntities)
        
        // When
        let result = mockRealmService.getPokedex(limit: 1, offset: 1)
        
        // Then
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result[0].name, "ivysaur")
    }
    
    func testGetPokedexWithOffsetAndLimit() {
        // Given
        let pokemonEntities = MockData.samplePokemonEntities
        mockRealmService.storePokedex(pokemonEntities)
        
        // When
        let result = mockRealmService.getPokedex(limit: 2, offset: 0)
        
        // Then
        XCTAssertEqual(result.count, 2)
        XCTAssertEqual(result[0].name, "bulbasaur")
        XCTAssertEqual(result[1].name, "ivysaur")
    }
    
    func testStorePokemon() {
        // Given
        let abilities = [Pokemon.Ability(
            ability: Pokemon.AbilityInfo(name: "static", detailURL: "https://pokeapi.co/api/v2/ability/9/"),
            isHidden: false,
            slot: 1
        )]
        let sprites = Pokemon.Sprites(
            other: Pokemon.SpritesOther(
                officialArtwork: Pokemon.OfficialArtwork(
                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
                )
            )
        )
        let types = [Pokemon.Types(
            slot: 1,
            type: Pokemon.TypesInfo(name: "electric", url: "https://pokeapi.co/api/v2/type/13/")
        )]
        let stats = [Pokemon.Stats(
            baseStat: 35,
            effort: 0,
            stat: Pokemon.StatsInfo(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
        )]
        
        // When
        mockRealmService.storePokemon(
            id: 25,
            name: "pikachu",
            abilities: abilities,
            spritesOther: sprites,
            types: types,
            weight: 60.0,
            height: 4.0,
            stats: stats
        )
        
        // Then
        XCTAssertEqual(mockRealmService.storedPokemon.count, 1)
        XCTAssertNotNil(mockRealmService.storedPokemon["pikachu"])
        XCTAssertEqual(mockRealmService.storedPokemon["pikachu"]?.name, "pikachu")
        XCTAssertEqual(mockRealmService.storedPokemon["pikachu"]?.idPokemon, 25)
    }
    
    func testGetPokemon() {
        // Given
        let abilities = [Pokemon.Ability(
            ability: Pokemon.AbilityInfo(name: "static", detailURL: "https://pokeapi.co/api/v2/ability/9/"),
            isHidden: false,
            slot: 1
        )]
        let sprites = Pokemon.Sprites(
            other: Pokemon.SpritesOther(
                officialArtwork: Pokemon.OfficialArtwork(
                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
                )
            )
        )
        let types = [Pokemon.Types(
            slot: 1,
            type: Pokemon.TypesInfo(name: "electric", url: "https://pokeapi.co/api/v2/type/13/")
        )]
        let stats = [Pokemon.Stats(
            baseStat: 35,
            effort: 0,
            stat: Pokemon.StatsInfo(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
        )]
        
        mockRealmService.storePokemon(
            id: 25,
            name: "pikachu",
            abilities: abilities,
            spritesOther: sprites,
            types: types,
            weight: 60.0,
            height: 4.0,
            stats: stats
        )
        
        // When
        let result = mockRealmService.getPokemon(withName: "pikachu")
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "pikachu")
        XCTAssertEqual(result?.idPokemon, 25)
    }
    
    func testGetPokemonNotFound() {
        // Given & When
        let result = mockRealmService.getPokemon(withName: "nonexistent")
        
        // Then
        XCTAssertNil(result)
    }
    
    func testStorePokemonSpecies() {
        // Given
        let flavourTextEntries = [PokemonSpecies.FlavourTextEntry(
            flavourText: "When several of these POKéMON gather, their electricity could build and cause lightning storms."
        )]
        
        // When
        mockRealmService.storePokemonSpecies(flavourTextEntries: flavourTextEntries)
        
        // Then
        XCTAssertEqual(mockRealmService.storedSpecies.count, 1)
        XCTAssertNotNil(mockRealmService.storedSpecies["test"])
    }
    
    func testGetPokemonSpecies() {
        // Given
        let flavourTextEntries = [PokemonSpecies.FlavourTextEntry(
            flavourText: "When several of these POKéMON gather, their electricity could build and cause lightning storms."
        )]
        mockRealmService.storePokemonSpecies(flavourTextEntries: flavourTextEntries)
        
        // When
        let result = mockRealmService.getPokemonSpecies(withName: "test")
        
        // Then
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.name, "test")
    }
    
    func testGetPokemonSpeciesNotFound() {
        // Given & When
        let result = mockRealmService.getPokemonSpecies(withName: "nonexistent")
        
        // Then
        XCTAssertNil(result)
    }
    
    func testMultiplePokemonStorage() {
        // Given
        let abilities = [Pokemon.Ability(
            ability: Pokemon.AbilityInfo(name: "static", detailURL: "https://pokeapi.co/api/v2/ability/9/"),
            isHidden: false,
            slot: 1
        )]
        let sprites = Pokemon.Sprites(
            other: Pokemon.SpritesOther(
                officialArtwork: Pokemon.OfficialArtwork(
                    frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
                )
            )
        )
        let types = [Pokemon.Types(
            slot: 1,
            type: Pokemon.TypesInfo(name: "electric", url: "https://pokeapi.co/api/v2/type/13/")
        )]
        let stats = [Pokemon.Stats(
            baseStat: 35,
            effort: 0,
            stat: Pokemon.StatsInfo(name: "hp", url: "https://pokeapi.co/api/v2/stat/1/")
        )]
        
        // When
        mockRealmService.storePokemon(
            id: 25,
            name: "pikachu",
            abilities: abilities,
            spritesOther: sprites,
            types: types,
            weight: 60.0,
            height: 4.0,
            stats: stats
        )
        
        mockRealmService.storePokemon(
            id: 1,
            name: "bulbasaur",
            abilities: abilities,
            spritesOther: sprites,
            types: types,
            weight: 69.0,
            height: 7.0,
            stats: stats
        )
        
        // Then
        XCTAssertEqual(mockRealmService.storedPokemon.count, 2)
        XCTAssertNotNil(mockRealmService.storedPokemon["pikachu"])
        XCTAssertNotNil(mockRealmService.storedPokemon["bulbasaur"])
        XCTAssertEqual(mockRealmService.storedPokemon["pikachu"]?.idPokemon, 25)
        XCTAssertEqual(mockRealmService.storedPokemon["bulbasaur"]?.idPokemon, 1)
    }
}
