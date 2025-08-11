//
//  PokedexViewModel.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 10/08/25.
//

import Combine
import Foundation

final class PokedexViewModel: ObservableObject {
    
    @Published var pokemons: [Pokemon.Result] = []
    @Published var errorMessage: String = ""
    private var cancellables: Set<AnyCancellable> = []
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
        self.fetchPokemon()
    }
    
    func fetchPokemon() {
        apiService.fetchPokemon()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let `self` = self else { return }
                if case .failure(let error) = result {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] result in
                guard let `self` = self else { return }
                self.pokemons.append(contentsOf: result.results)
            }
            .store(in: &cancellables)
    }
}
