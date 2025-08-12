//
//  APIService.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 10/08/25.
//

import Alamofire
import Combine

protocol APIServiceProtocol {
    func fetchPokedex(endPoint: APIService.EndPoint, method: HTTPMethod, parameters: Parameters?) -> AnyPublisher<Pokedex.Response, AFError>
    func fetchPokemon(endPoint: APIService.EndPoint, path: [String], method: HTTPMethod, parameters: Parameters?) -> AnyPublisher<Pokemon.Response, AFError>
    func fetchPokemonSpecies(endPoint: APIService.EndPoint, path: [String], method: HTTPMethod, parameters: Parameters?) -> AnyPublisher<PokemonSpecies.Response, AFError>
}

final class APIService: APIServiceProtocol {
    
    enum EndPoint: String {
        case pokemon = "pokemon/"
        case pokemonSpecies = "pokemon-species/"
    }
    
    private func fullURL(api: EndPoint, path: [String] = []) -> String {
        let domain: String = "https://pokeapi.co/api/v2/"
        var urlString: String = "\(domain)\(api.rawValue)"
        path.forEach { item in
            urlString = "\(urlString)\(item)/"
        }
        return urlString
    }
    
    func fetchPokedex(endPoint: APIService.EndPoint, method: HTTPMethod = .get, parameters: Parameters? = nil) -> AnyPublisher<Pokedex.Response, AFError> {
        AF.request(fullURL(api: endPoint), method: method, parameters: parameters)
            .publishDecodable(type: Pokedex.Response.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func fetchPokemon(endPoint: EndPoint, path: [String], method: HTTPMethod, parameters: Parameters?) -> AnyPublisher<Pokemon.Response, AFError> {
        AF.request(fullURL(api: endPoint, path: path), method: method, parameters: parameters)
            .publishDecodable(type: Pokemon.Response.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func fetchPokemonSpecies(endPoint: EndPoint, path: [String], method: HTTPMethod, parameters: Parameters?) -> AnyPublisher<PokemonSpecies.Response, AFError> {
        AF.request(fullURL(api: endPoint, path: path), method: method, parameters: parameters)
            .publishDecodable(type: PokemonSpecies.Response.self)
            .value()
            .eraseToAnyPublisher()
    }
}
