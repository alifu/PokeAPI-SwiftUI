//
//  PokedexViewModelTests.swift
//  PokeAPI-SwiftUITests
//
//  Created by alif rama on 08/08/25.
//

import XCTest
import Combine
@testable import PokeAPI_SwiftUI

final class PokedexViewModelTests: XCTestCase {
    
    var viewModel: PokedexViewModel!
    var mockAPIService: MockAPIService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = PokedexViewModel(apiService: mockAPIService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testInitialState() {
        // Given & When & Then
        // Note: pokemons might not be empty if fetchPokedex() was called in init
        XCTAssertEqual(viewModel.searchText, "")
        XCTAssertEqual(viewModel.errorMessage, "")
        XCTAssertFalse(viewModel.showSortMenu)
        XCTAssertEqual(viewModel.selectedOption, .none)
        
        // Test that the Combine pipeline is set up correctly
        XCTAssertNotNil(viewModel.filteredPokemons)
    }
    
    func testSearchTextFiltering() {
        // Given
        let pokemons = [
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/1/", name: "bulbasaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/2/", name: "ivysaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/25/", name: "pikachu")
        ]
        viewModel.pokemons = pokemons
        
        // When
        viewModel.searchText = "bul"
        
        // Then - Use a more direct approach with RunLoop
        let expectation = XCTestExpectation(description: "Search filtering")
        
        // Give the Combine pipeline time to process
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let filteredPokemons = self.viewModel.filteredPokemons
            XCTAssertEqual(filteredPokemons.count, 1)
            XCTAssertEqual(filteredPokemons.first?.name, "bulbasaur")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchTextCaseInsensitive() {
        // Given
        let pokemons = [
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/1/", name: "bulbasaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/2/", name: "ivysaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/25/", name: "pikachu")
        ]
        viewModel.pokemons = pokemons
        
        // When
        viewModel.searchText = "BUL"
        
        // Then
        let expectation = XCTestExpectation(description: "Case insensitive search")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let filteredPokemons = self.viewModel.filteredPokemons
            XCTAssertEqual(filteredPokemons.count, 1)
            XCTAssertEqual(filteredPokemons.first?.name, "bulbasaur")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSortByName() {
        // Given
        let pokemons = [
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/25/", name: "pikachu"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/1/", name: "bulbasaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/2/", name: "ivysaur")
        ]
        viewModel.pokemons = pokemons
        
        // When
        viewModel.selectedOption = .name
        
        // Then
        let expectation = XCTestExpectation(description: "Sort by name")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let filteredPokemons = self.viewModel.filteredPokemons
            XCTAssertEqual(filteredPokemons.count, 3)
            XCTAssertEqual(filteredPokemons[0].name, "bulbasaur")
            XCTAssertEqual(filteredPokemons[1].name, "ivysaur")
            XCTAssertEqual(filteredPokemons[2].name, "pikachu")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSortByNumber() {
        // Given
        let pokemons = [
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/25/", name: "pikachu"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/1/", name: "bulbasaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/2/", name: "ivysaur")
        ]
        viewModel.pokemons = pokemons
        
        // When
        viewModel.selectedOption = .number
        
        // Then
        let expectation = XCTestExpectation(description: "Sort by number")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let filteredPokemons = self.viewModel.filteredPokemons
            XCTAssertEqual(filteredPokemons.count, 3)
            XCTAssertEqual(filteredPokemons[0].name, "bulbasaur") // ID: 1
            XCTAssertEqual(filteredPokemons[1].name, "ivysaur")   // ID: 2
            XCTAssertEqual(filteredPokemons[2].name, "pikachu")   // ID: 25
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchAndSortCombined() {
        // Given
        let pokemons = [
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/25/", name: "pikachu"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/1/", name: "bulbasaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/2/", name: "ivysaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/3/", name: "venusaur")
        ]
        viewModel.pokemons = pokemons
        
        // When
        viewModel.searchText = "aur"
        viewModel.selectedOption = .name
        
        // Then
        let expectation = XCTestExpectation(description: "Search and sort combined")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            let filteredPokemons = self.viewModel.filteredPokemons
            XCTAssertEqual(filteredPokemons.count, 3)
            XCTAssertEqual(filteredPokemons[0].name, "bulbasaur")
            XCTAssertEqual(filteredPokemons[1].name, "ivysaur")
            XCTAssertEqual(filteredPokemons[2].name, "venusaur")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testEmptySearchReturnsAllPokemons() {
        // Given
        let pokemons = [
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/1/", name: "bulbasaur"),
            Pokedex.Result(url: "https://pokeapi.co/api/v2/pokemon/2/", name: "ivysaur")
        ]
        viewModel.pokemons = pokemons
        
        // When
        viewModel.searchText = ""
        
        // Then
        let expectation = XCTestExpectation(description: "Empty search")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            let filteredPokemons = self.viewModel.filteredPokemons
            XCTAssertEqual(filteredPokemons.count, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testShowSortMenuToggle() {
        // Given
        XCTAssertFalse(viewModel.showSortMenu)
        
        // When
        viewModel.showSortMenu = true
        
        // Then
        XCTAssertTrue(viewModel.showSortMenu)
        
        // When
        viewModel.showSortMenu = false
        
        // Then
        XCTAssertFalse(viewModel.showSortMenu)
    }
}
