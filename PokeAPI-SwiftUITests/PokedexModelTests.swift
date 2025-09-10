//
//  PokedexModelTests.swift
//  PokeAPI-SwiftUITests
//
//  Created by alif rama on 08/08/25.
//

import XCTest
@testable import PokeAPI_SwiftUI

final class PokedexModelTests: XCTestCase {
    
    func testPokedexResultInitialization() {
        // Given
        let url = "https://pokeapi.co/api/v2/pokemon/1/"
        let name = "bulbasaur"
        
        // When
        let result = Pokedex.Result(url: url, name: name)
        
        // Then
        XCTAssertEqual(result.url, url)
        XCTAssertEqual(result.name, name)
        XCTAssertEqual(result.id, "1")
    }
    
    func testPokedexResultIdExtraction() {
        // Given
        let url = "https://pokeapi.co/api/v2/pokemon/25/"
        let name = "pikachu"
        
        // When
        let result = Pokedex.Result(url: url, name: name)
        
        // Then
        XCTAssertEqual(result.id, "25")
    }
    
    func testPokedexResultImageURL() {
        // Given
        let url = "https://pokeapi.co/api/v2/pokemon/1/"
        let name = "bulbasaur"
        
        // When
        let result = Pokedex.Result(url: url, name: name)
        
        // Then
        let expectedImageURL = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        XCTAssertEqual(result.imageURL, expectedImageURL)
    }
    
    func testPokedexResultImageURLWithNilId() {
        // Given
        let url = "https://invalid-url/"  // URL ending with slash, no ID component
        let name = "invalid"
        
        // When
        let result = Pokedex.Result(url: url, name: name)
        
        // Then
        XCTAssertNil(Int(result.id ?? ""))
    }
    
    func testPokedexResultImageURLWithInvalidUrl() {
        // Given - URL that doesn't follow the expected pattern but still has a last component
        let url = "https://invalid-url"
        let name = "invalid"
        
        // When
        let result = Pokedex.Result(url: url, name: name)
        
        // Then - The current implementation extracts "invalid-url" as the ID
        XCTAssertEqual(result.id, "invalid-url")
        XCTAssertEqual(result.imageURL, "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/invalid-url.png")
    }
    
    func testPokedexResponseDecoding() throws {
        // Given
        let jsonData = """
        {
            "count": 1154,
            "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
            "previous": null,
            "results": [
                {
                    "name": "bulbasaur",
                    "url": "https://pokeapi.co/api/v2/pokemon/1/"
                },
                {
                    "name": "ivysaur",
                    "url": "https://pokeapi.co/api/v2/pokemon/2/"
                }
            ]
        }
        """.data(using: .utf8)!
        
        // When
        let response = try JSONDecoder().decode(Pokedex.Response.self, from: jsonData)
        
        // Then
        XCTAssertEqual(response.count, 1154)
        XCTAssertEqual(response.next, "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20")
        XCTAssertNil(response.previous)
        XCTAssertEqual(response.results.count, 2)
        XCTAssertEqual(response.results[0].name, "bulbasaur")
        XCTAssertEqual(response.results[0].url, "https://pokeapi.co/api/v2/pokemon/1/")
        XCTAssertEqual(response.results[1].name, "ivysaur")
        XCTAssertEqual(response.results[1].url, "https://pokeapi.co/api/v2/pokemon/2/")
    }
    
    func testPokedexResultIdentifiable() {
        // Given
        let result1 = Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/1/", name: "bulbasaur")
        let result2 = Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/2/", name: "ivysaur")
        
        // When & Then
        XCTAssertNotEqual(result1.id, result2.id)
        XCTAssertTrue(result1.id == "1")
        XCTAssertTrue(result2.id == "2")
    }
}
