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
    
    let scene = MVCScene()
    
    var modelLayer: MVCLayer?
    var captionLayer: MVCLayer?
    
    var nodeLabel: MVCLayer?
    
    let controller: GraphicController
    
    init() {
        model = AS4Model()
        controller = GraphicController(scene: scene)
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        model = try JSONDecoder().decode(AS4Model.self, from: data)
        controller = GraphicController(scene: scene)
    }

    func updateView() {
        modelLayer = MVCLayer("Model")
        captionLayer = MVCLayer("Caption")
        scene.append(layer: modelLayer!)
        scene.append(layer: captionLayer!)
        
        nodeLabel = MVCLayer("Node")
        scene.append(layer: nodeLabel!)
    }
}

class SharedStore: ObservableObject {
    var stores: [Store] = []
}
