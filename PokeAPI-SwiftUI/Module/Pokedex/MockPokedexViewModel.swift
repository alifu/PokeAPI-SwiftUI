//
//  MockPokedexViewModel.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 11/08/25.
//

final class MockPokedexViewModel: PokedexViewModel {
    
    override func fetchPokedex() {
        self.pokemons.append(contentsOf: [
            Pokedex.Result(url: "", name: "Bulbasaur"),
            Pokedex.Result(url: "", name: "ivysaur")
        ])
    }
}
