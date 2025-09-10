//
//  DoubleExtensionTests.swift
//  PokeAPI-SwiftUITests
//
//  Created by alif rama on 08/08/25.
//

import XCTest
@testable import PokeAPI_SwiftUI

final class DoubleExtensionTests: XCTestCase {
    
    func testToKgConversion() {
        // Given & When & Then
        XCTAssertEqual(60.0.toKg, "6 kg")
        XCTAssertEqual(100.0.toKg, "10 kg")
        XCTAssertEqual(50.0.toKg, "5 kg")
        XCTAssertEqual(0.0.toKg, "0 kg")
        XCTAssertEqual(1.0.toKg, "0.1 kg")
    }
    
    func testToMetersConversion() {
        // Given & When & Then
        XCTAssertEqual(40.0.toMeters, "4 m")
        XCTAssertEqual(100.0.toMeters, "10 m")
        XCTAssertEqual(50.0.toMeters, "5 m")
        XCTAssertEqual(0.0.toMeters, "0 m")
        XCTAssertEqual(1.0.toMeters, "0.1 m")
    }
    
    func testTrailingZeroRemoval() {
        // Given & When & Then
        XCTAssertEqual(60.0.toKg, "6 kg") // Should remove trailing zero
        XCTAssertEqual(60.5.toKg, "6.05 kg") // Should keep decimal
        XCTAssertEqual(60.10.toKg, "6.01 kg") // Should remove trailing zero
        XCTAssertEqual(60.00.toKg, "6 kg") // Should remove all trailing zeros
    }
    
    func testEdgeCases() {
        // Given & When & Then
        XCTAssertEqual(0.0.toKg, "0 kg")
        XCTAssertEqual(0.0.toMeters, "0 m")
        XCTAssertEqual(0.1.toKg, "0.01 kg")
        XCTAssertEqual(0.1.toMeters, "0.01 m")
    }
    
    func testLargeNumbers() {
        // Given & When & Then
        XCTAssertEqual(1000.0.toKg, "100 kg")
        XCTAssertEqual(1000.0.toMeters, "100 m")
        XCTAssertEqual(999.9.toKg, "99.99 kg")
        XCTAssertEqual(999.9.toMeters, "99.99 m")
    }
    
    func testDecimalPrecision() {
        // Given & When & Then
        XCTAssertEqual(12.5.toKg, "1.25 kg")
        XCTAssertEqual(12.5.toMeters, "1.25 m")
        XCTAssertEqual(12.50.toKg, "1.25 kg") // Should remove trailing zero
        XCTAssertEqual(12.500.toKg, "1.25 kg") // Should remove all trailing zeros
    }
}
