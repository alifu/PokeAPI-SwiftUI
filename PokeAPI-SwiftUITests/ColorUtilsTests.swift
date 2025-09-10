//
//  ColorUtilsTests.swift
//  PokeAPI-SwiftUITests
//
//  Created by alif rama on 08/08/25.
//

import XCTest
import SwiftUI
@testable import PokeAPI_SwiftUI

final class ColorUtilsTests: XCTestCase {
    
    func testColorTypeRawValues() {
        // Given & When & Then
        XCTAssertEqual(ColorType.bug.rawValue, "bug")
        XCTAssertEqual(ColorType.dark.rawValue, "dark")
        XCTAssertEqual(ColorType.dragon.rawValue, "dragon")
        XCTAssertEqual(ColorType.electric.rawValue, "electric")
        XCTAssertEqual(ColorType.fairy.rawValue, "fairy")
        XCTAssertEqual(ColorType.fighting.rawValue, "fighting")
        XCTAssertEqual(ColorType.fire.rawValue, "fire")
        XCTAssertEqual(ColorType.flying.rawValue, "flying")
        XCTAssertEqual(ColorType.ghost.rawValue, "ghost")
        XCTAssertEqual(ColorType.grass.rawValue, "grass")
        XCTAssertEqual(ColorType.ground.rawValue, "ground")
        XCTAssertEqual(ColorType.ice.rawValue, "ice")
        XCTAssertEqual(ColorType.poison.rawValue, "poison")
        XCTAssertEqual(ColorType.psychic.rawValue, "psychic")
        XCTAssertEqual(ColorType.rock.rawValue, "rock")
        XCTAssertEqual(ColorType.steel.rawValue, "steel")
        XCTAssertEqual(ColorType.water.rawValue, "water")
        XCTAssertEqual(ColorType.none.rawValue, "none")
    }
    
    func testColorTypeFromRawValue() {
        // Given & When & Then
        XCTAssertEqual(ColorType(rawValue: "bug"), .bug)
        XCTAssertEqual(ColorType(rawValue: "fire"), .fire)
        XCTAssertEqual(ColorType(rawValue: "water"), .water)
        XCTAssertEqual(ColorType(rawValue: "grass"), .grass)
        XCTAssertEqual(ColorType(rawValue: "electric"), .electric)
        XCTAssertEqual(ColorType(rawValue: "psychic"), .psychic)
        XCTAssertEqual(ColorType(rawValue: "ice"), .ice)
        XCTAssertEqual(ColorType(rawValue: "dragon"), .dragon)
        XCTAssertEqual(ColorType(rawValue: "dark"), .dark)
        XCTAssertEqual(ColorType(rawValue: "fairy"), .fairy)
        XCTAssertEqual(ColorType(rawValue: "unknown"), nil)
    }
    
    func testColorStringToTypeFunction() {
        // Given & When & Then
        XCTAssertEqual(colorStringToType("bug"), ColorType.bug.color)
        XCTAssertEqual(colorStringToType("fire"), ColorType.fire.color)
        XCTAssertEqual(colorStringToType("water"), ColorType.water.color)
        XCTAssertEqual(colorStringToType("grass"), ColorType.grass.color)
        XCTAssertEqual(colorStringToType("electric"), ColorType.electric.color)
        XCTAssertEqual(colorStringToType("psychic"), ColorType.psychic.color)
        XCTAssertEqual(colorStringToType("ice"), ColorType.ice.color)
        XCTAssertEqual(colorStringToType("dragon"), ColorType.dragon.color)
        XCTAssertEqual(colorStringToType("dark"), ColorType.dark.color)
        XCTAssertEqual(colorStringToType("fairy"), ColorType.fairy.color)
        XCTAssertEqual(colorStringToType("unknown"), ColorType.none.color)
        XCTAssertEqual(colorStringToType(nil), ColorType.none.color)
    }
    
    func testColorStringToTypeCaseInsensitive() {
        // Given & When & Then
        XCTAssertEqual(colorStringToType("BUG"), ColorType.bug.color)
        XCTAssertEqual(colorStringToType("Fire"), ColorType.fire.color)
        XCTAssertEqual(colorStringToType("WATER"), ColorType.water.color)
        XCTAssertEqual(colorStringToType("Grass"), ColorType.grass.color)
    }
    
    func testColorUtilsStaticColors() {
        // Given & When & Then - Test that colors are properly defined
        XCTAssertNotNil(ColorUtils.primary)
        XCTAssertNotNil(ColorUtils.bug)
        XCTAssertNotNil(ColorUtils.dark)
        XCTAssertNotNil(ColorUtils.dragon)
        XCTAssertNotNil(ColorUtils.electric)
        XCTAssertNotNil(ColorUtils.fairy)
        XCTAssertNotNil(ColorUtils.fighting)
        XCTAssertNotNil(ColorUtils.fire)
        XCTAssertNotNil(ColorUtils.flying)
        XCTAssertNotNil(ColorUtils.ghost)
        XCTAssertNotNil(ColorUtils.grass)
        XCTAssertNotNil(ColorUtils.ground)
        XCTAssertNotNil(ColorUtils.ice)
        XCTAssertNotNil(ColorUtils.poison)
        XCTAssertNotNil(ColorUtils.psychic)
        XCTAssertNotNil(ColorUtils.rock)
        XCTAssertNotNil(ColorUtils.steel)
        XCTAssertNotNil(ColorUtils.water)
        XCTAssertNotNil(ColorUtils.grayscaleDark)
        XCTAssertNotNil(ColorUtils.grayscaleMedium)
        XCTAssertNotNil(ColorUtils.grayscaleLight)
        XCTAssertNotNil(ColorUtils.background)
        XCTAssertNotNil(ColorUtils.white)
        XCTAssertNotNil(ColorUtils.wireframe)
    }
}
