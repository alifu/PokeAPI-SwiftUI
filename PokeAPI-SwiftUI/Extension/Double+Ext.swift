//
//  Double+Ext.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 12/08/25.
//

import Foundation

extension Double {
    var toKg: String {
        return "\(forTrailingZero(self / 10)) kg"
    }
    
    var toMeters: String {
        return "\(forTrailingZero(self / 10)) m"
    }
    
    private func forTrailingZero(_ value: Double) -> String {
        return String(format: "%g", value)
    }
}
