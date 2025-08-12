//
//  PokeAPI_SwiftUIApp.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 08/08/25.
//

import SwiftUI

@main
struct PokeAPI_SwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                PokedexView()
            }
        }
    }
}
