//
//  Store.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import Analic

final class Store {
    
    var model: Model
    
    let scene = GameScene()
    let solver = ALCLinerStaticSolver()
    
    var modelLayer: MVCLayer!
    var captionLayer: MVCLayer!
    
    var nodeLabelLayer: MVCLayer!
    var beamLabelLayer: MVCLayer!
    
    let controller: GraphicController
    
    init() {
        controller = GraphicController(scene: scene)
        model = Model()
        
        controller.store = self
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        controller = GraphicController(scene: scene)
        model = try JSONDecoder().decode(Model.self, from: data)
        
        controller.store = self
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
        
        model.updateNodes(layer: modelLayer, labelLayer: nodeLabelLayer)
        model.updateBeams(layer: modelLayer, labelLayer: beamLabelLayer)
    }
}

class SharedStore: ObservableObject {
    var stores: [Store] = []
}
