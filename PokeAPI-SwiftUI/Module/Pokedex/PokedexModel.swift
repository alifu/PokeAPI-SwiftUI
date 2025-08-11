//
//  PokedexModel.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 10/08/25.
//

import Foundation

struct Pokemon {
    
    struct Request {
        let limit: Int
        let offset: Int
    }
    
    struct Response: Decodable {
        let count: Int
        let next: String?
        let previous: String?
        let results: [Result]
    }
    
    struct Result: Identifiable, Decodable {
        let url: String
        let name: String
        
        var id: String? {
            return url
                .split(separator: "/")
                .last
                .map(String.init)
        }
        
        var imageURL: String? {
            guard let id = id else { return nil }
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        }
    }
}
