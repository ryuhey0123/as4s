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
    
    var modelLayer: MVCLayer!
    var captionLayer: MVCLayer!
    
    var nodeLabelLayer: MVCLayer!
    var beamLabelLayer: MVCLayer!
    
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
        nodeLabelLayer = MVCLayer("NodeLabel")
        beamLabelLayer = MVCLayer("BeamLabel")
        scene.append(layer: modelLayer)
        scene.append(layer: captionLayer)
        scene.append(layer: nodeLabelLayer)
        scene.append(layer: beamLabelLayer)
    }
}

class SharedStore: ObservableObject {
    var stores: [Store] = []
}
