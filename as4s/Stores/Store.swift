//
//  as4sDocument.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

final class Store {
    var model: AS4Model
    
    let scene = MVCScene()
    let overlayScene = MVCOverlayScene()
    
    var controller: GraphicController
    
    init() {
        self.model = AS4Model()
        self.controller = GraphicController(scene: scene, overlayScene: overlayScene)
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.model = try JSONDecoder().decode(AS4Model.self, from: data)
        self.controller = GraphicController(scene: scene, overlayScene: overlayScene)
    }
}

class SharedStore: ObservableObject {
    var stores: [Store] = []
}
