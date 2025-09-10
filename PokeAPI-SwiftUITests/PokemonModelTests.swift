//
//  PokemonModelTests.swift
//  PokeAPI-SwiftUITests
//
//  Created by alif rama on 08/08/25.
//

import XCTest
@testable import PokeAPI_SwiftUI

final class PokemonModelTests: XCTestCase {
    
    func testPokemonResponseDecoding() throws {
        // Given
        let jsonData = """
        {
            "id": 25,
            "name": "pikachu",
            "abilities": [
                {
                    "ability": {
                        "name": "static",
                        "url": "https://pokeapi.co/api/v2/ability/9/"
                    },
                    "is_hidden": false,
                    "slot": 1
                }
            ],
            "sprites": {
                "other": {
                    "official-artwork": {
                        "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
                    }
                }
            },
            "types": [
                {
                    "slot": 1,
                    "type": {
                        "name": "electric",
                        "url": "https://pokeapi.co/api/v2/type/13/"
                    }
                }
            ],
            "stats": [
                {
                    "base_stat": 35,
                    "effort": 0,
                    "stat": {
                        "name": "hp",
                        "url": "https://pokeapi.co/api/v2/stat/1/"
                    }
                }
            ],
            "height": 4.0,
            "weight": 60.0
        }
        """.data(using: .utf8)!
        
        // When
        let response = try JSONDecoder().decode(Pokemon.Response.self, from: jsonData)
        
        // Then
        XCTAssertEqual(response.id, 25)
        XCTAssertEqual(response.name, "pikachu")
        XCTAssertEqual(response.height, 4.0)
        XCTAssertEqual(response.weight, 60.0)
        XCTAssertEqual(response.abilities.count, 1)
        XCTAssertEqual(response.abilities[0].ability.name, "static")
        XCTAssertEqual(response.abilities[0].isHidden, false)
        XCTAssertEqual(response.abilities[0].slot, 1)
        XCTAssertEqual(response.types.count, 1)
        XCTAssertEqual(response.types[0].type.name, "electric")
        XCTAssertEqual(response.stats.count, 1)
        XCTAssertEqual(response.stats[0].baseStat, 35)
        XCTAssertEqual(response.stats[0].stat.name, "hp")
    }
    
    func testPokemonStatsInfoDisplayName() {
        // Given & When & Then
        XCTAssertEqual(Pokemon.StatsInfo(name: "hp", url: "").displayName(), "HP")
        XCTAssertEqual(Pokemon.StatsInfo(name: "attack", url: "").displayName(), "ATK")
        XCTAssertEqual(Pokemon.StatsInfo(name: "defense", url: "").displayName(), "DEF")
        XCTAssertEqual(Pokemon.StatsInfo(name: "special-attack", url: "").displayName(), "SATK")
        XCTAssertEqual(Pokemon.StatsInfo(name: "special-defense", url: "").displayName(), "SDEF")
        XCTAssertEqual(Pokemon.StatsInfo(name: "speed", url: "").displayName(), "SPD")
        XCTAssertEqual(Pokemon.StatsInfo(name: "unknown", url: "").displayName(), "-")
    }
    
    func testPokemonStatsInfoDisplayNameCaseInsensitive() {
        // Given & When & Then
        XCTAssertEqual(Pokemon.StatsInfo(name: "HP", url: "").displayName(), "HP")
        XCTAssertEqual(Pokemon.StatsInfo(name: "ATTACK", url: "").displayName(), "ATK")
        XCTAssertEqual(Pokemon.StatsInfo(name: "Defense", url: "").displayName(), "DEF")
    }
    
    func testPokemonSpeciesResponseDecoding() throws {
        // Given
        let jsonData = """
        {
            "flavor_text_entries": [
                {
                    "flavor_text": "When several of these POKéMON gather, their electricity could build and cause lightning storms."
                }
            ]
        }
        """.data(using: .utf8)!
        
        // When
        let response = try JSONDecoder().decode(PokemonSpecies.Response.self, from: jsonData)
        
        // Then
        XCTAssertEqual(response.flavorTextEntries.count, 1)
        XCTAssertEqual(response.flavorTextEntries[0].flavourText, "When several of these POKéMON gather, their electricity could build and cause lightning storms.")
    }
    
    func testPokemonAbilityCodingKeys() throws {
        // Given
        let jsonData = """
        {
            "ability": {
                "name": "static",
                "url": "https://pokeapi.co/api/v2/ability/9/"
            },
            "is_hidden": true,
            "slot": 2
        }
        """.data(using: .utf8)!
        
        // When
        let ability = try JSONDecoder().decode(Pokemon.Ability.self, from: jsonData)
        
        // Then
        XCTAssertEqual(ability.ability.name, "static")
        XCTAssertEqual(ability.isHidden, true)
        XCTAssertEqual(ability.slot, 2)
    }
    
    func testPokemonSpritesCodingKeys() throws {
        // Given
        let jsonData = """
        {
            "other": {
                "official-artwork": {
                    "front_default": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png"
                }
            }
        }
        """.data(using: .utf8)!
        
        // When
        let sprites = try JSONDecoder().decode(Pokemon.Sprites.self, from: jsonData)
        
        // Then
        XCTAssertEqual(sprites.other.officialArtwork.frontDefault, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png")
    }
}
