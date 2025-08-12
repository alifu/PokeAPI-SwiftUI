//
//  ImagePipeline+Ext.swift
//  PokeAPI-SwiftUI
//
//  Created by alif rama on 11/08/25.
//

import Nuke

// Create a shared pipeline with disk cache
extension ImagePipeline {
    static let cached = ImagePipeline {
        let dataCache = try? DataCache(name: "com.example.app.datacache")
        dataCache?.sizeLimit = 200 * 1024 * 1024 // 200 MB
        $0.dataCache = dataCache
        $0.imageCache = ImageCache.shared
    }
}
