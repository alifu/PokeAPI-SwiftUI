//
//  APIServiceTests.swift
//  PokeAPI-SwiftUITests
//
//  Created by alif rama on 08/08/25.
//

import XCTest
import Combine
import Alamofire
@testable import PokeAPI_SwiftUI

final class APIServiceTests: XCTestCase {
    
    var apiService: APIService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        apiService = APIService()
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        apiService = nil
        super.tearDown()
    }
    
    func testAPIServiceEndpoints() {
        // Given & When & Then
        XCTAssertEqual(APIService.EndPoint.pokemon.rawValue, "pokemon/")
        XCTAssertEqual(APIService.EndPoint.pokemonSpecies.rawValue, "pokemon-species/")
    }
    
    func testURLGenerationThroughPublicInterface() {
        // Given
        let pokemonEndpoint = APIService.EndPoint.pokemon
        let pokemonSpeciesEndpoint = APIService.EndPoint.pokemonSpecies
        
        // When & Then - Test that endpoints have correct raw values
        XCTAssertEqual(pokemonEndpoint.rawValue, "pokemon/")
        XCTAssertEqual(pokemonSpeciesEndpoint.rawValue, "pokemon-species/")
        
        // Note: We can't directly test fullURL since it's private, but we can test
        // the public interface and endpoint configuration
    }
    
    func testAPIServiceProtocolConformance() {
        // Given & When & Then
        XCTAssertTrue(apiService is APIServiceProtocol)
    }
    
    func testAPIServiceInitialization() {
        // Given & When
        let service = APIService()
        
        // Then
        XCTAssertNotNil(service)
    }
    
    func testEndpointRawValues() {
        // Given & When & Then
        XCTAssertEqual(APIService.EndPoint.pokemon.rawValue, "pokemon/")
        XCTAssertEqual(APIService.EndPoint.pokemonSpecies.rawValue, "pokemon-species/")
    }
    
    func testEndpointEquality() {
        // Given & When & Then
        XCTAssertEqual(APIService.EndPoint.pokemon, .pokemon)
        XCTAssertEqual(APIService.EndPoint.pokemonSpecies, .pokemonSpecies)
        XCTAssertNotEqual(APIService.EndPoint.pokemon, .pokemonSpecies)
    }
    
    // Note: The following tests would require network access and are more integration tests
    // In a real-world scenario, you might want to use URLProtocol mocking or dependency injection
    // to test the actual network calls without making real API requests
}
