//
//  APIService.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 10/08/25.
//

import Alamofire
import Combine

protocol APIServiceProtocol {
    func fetchPokemon() -> AnyPublisher<Pokemon.Response, AFError>
}

final class APIService: APIServiceProtocol {
    
    func fetchPokemon() -> AnyPublisher<Pokemon.Response, AFError> {
        AF.request("https://pokeapi.co/api/v2/pokemon?limit=24&offset=0")
            .publishDecodable(type: Pokemon.Response.self)
            .value()
            .eraseToAnyPublisher()
    }
}
