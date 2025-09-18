//
//  PokemonNavigator.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 18/09/25.
//

import Foundation
import Combine

final class PokemonNavigator {
    
    private let allResults: [Pokedex.Result]
    
    /// Equivalent to BehaviorRelay in RxSwift
    let currentSubject: CurrentValueSubject<Pokedex.Result?, Never>
    
    init(results: [Pokedex.Result], startIndex: Int = 0) {
        self.allResults = results
        let start = results.indices.contains(startIndex) ? results[startIndex] : nil
        self.currentSubject = CurrentValueSubject(start)
    }
    
    func moveNext() {
        guard
            let current = currentSubject.value,
            let index = allResults.firstIndex(where: { $0.id == current.id }),
            index + 1 < allResults.count
        else { return }
        
        currentSubject.send(allResults[index + 1])
    }
    
    func movePrevious() {
        guard
            let current = currentSubject.value,
            let index = allResults.firstIndex(where: { $0.id == current.id }),
            index - 1 >= 0
        else { return }
        
        currentSubject.send(allResults[index - 1])
    }
}

