//
//  ViewModifierHelper.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 08/08/25.
//

import SwiftUI

struct ShadowIfNeeded: ViewModifier {
    var enabled: Bool
    func body(content: Content) -> some View {
        if enabled {
            content.shadow(color: Color.primary.opacity(0.12), radius: 4, x: 0, y: 2)
        } else {
            content
        }
    }
}
