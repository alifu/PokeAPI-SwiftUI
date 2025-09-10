//
//  SortComponentTypeTests.swift
//  PokeAPI-SwiftUITests
//
//  Created by alif rama on 08/08/25.
//

import XCTest
@testable import PokeAPI_SwiftUI

final class SortComponentTypeTests: XCTestCase {
    
    func testSortComponentTypeRawValues() {
        // Given & When & Then
        XCTAssertEqual(SortComponentType.number.rawValue, "number")
        XCTAssertEqual(SortComponentType.name.rawValue, "name")
        XCTAssertEqual(SortComponentType.none.rawValue, "none")
    }
    
    func testSortComponentTypeFromRawValue() {
        // Given & When & Then
        XCTAssertEqual(SortComponentType(rawValue: "number"), .number)
        XCTAssertEqual(SortComponentType(rawValue: "name"), .name)
        
        // Test the "none" case with explicit optional handling
        let noneType = SortComponentType(rawValue: "none")
        XCTAssertNotNil(noneType)
        XCTAssertEqual(noneType!, .none)
        
        XCTAssertNil(SortComponentType(rawValue: "invalid"))
    }
    
    func testSortComponentTypeEquality() {
        // Given & When & Then
        XCTAssertEqual(SortComponentType.number, .number)
        XCTAssertEqual(SortComponentType.name, .name)
        XCTAssertEqual(SortComponentType.none, .none)
        XCTAssertNotEqual(SortComponentType.number, .name)
        XCTAssertNotEqual(SortComponentType.name, .none)
        XCTAssertNotEqual(SortComponentType.number, .none)
    }
    
    func testSortComponentTypeAllCases() {
        // Given
        let allCases: [SortComponentType] = [.number, .name, .none]
        
        // When & Then
        XCTAssertEqual(allCases.count, 3)
        XCTAssertTrue(allCases.contains(.number))
        XCTAssertTrue(allCases.contains(.name))
        XCTAssertTrue(allCases.contains(.none))
    }
}
