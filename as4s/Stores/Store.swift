//
//  Store.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

final class Store {
    var model: AS4Model
    
    let scene: MVCScene = MVCScene()
    let overlayScene = MVCOverlayScene()

    var modelLayer: MVCLayer?
    var captionLayer: MVCLayer?
    
    var nodeLabel: MVCOverlayLayer?

    let controller: MVCGraphicController

    init() {
        model = AS4Model()
        controller = MVCGraphicController(scene: scene, overlayScene: overlayScene)
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        model = try JSONDecoder().decode(AS4Model.self, from: data)
        controller = MVCGraphicController(scene: scene, overlayScene: overlayScene)
    }

    func updateView() {
        modelLayer = MVCLayer("Model")
        captionLayer = MVCLayer("Caption")

        scene.append(layer: modelLayer!)
        scene.append(layer: captionLayer!)
        
        nodeLabel = MVCOverlayLayer("Node")
        
        overlayScene.append(layer: nodeLabel!)
    }
}

class SharedStore: ObservableObject {
    var stores: [Store] = []
}
