//
//  Store.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

final class Store {
    
    let model: Model
    
    let scene: GameScene
    let controller: GraphicController
    
    let modelLayer: MVCLayer = MVCLayer("Model")
    let captionLayer: MVCLayer = MVCLayer("Caption")
    let nodeLabelLayer: MVCLayer = MVCLayer("NodeLabel")
    let beamLabelLayer: MVCLayer = MVCLayer("BeamLabel")
    
    let openSeesBinaryURL: URL
    let tclEnvironment: [String : String]
    
    init(model: Model = Model()) {
        guard let binaryURL = Bundle.main.url(forResource: "OpenSees", withExtension: nil) else {
            fatalError("Not found OpenSees")
        }
        
        guard let tclURL = Bundle.main.url(forResource: "init.tcl", withExtension: nil) else {
            fatalError("Not found init.tcl")
        }
        
        var environment = ProcessInfo.processInfo.environment
        environment["TCL_LIBRARY"] = tclURL.deletingLastPathComponent().path
        
        let scene = GameScene()
        scene.append(layer: modelLayer)
        scene.append(layer: captionLayer)
        scene.append(layer: nodeLabelLayer)
        scene.append(layer: beamLabelLayer)
        
        self.model = model
        self.scene = scene
        self.controller = GraphicController(scene: self.scene)
        self.openSeesBinaryURL = binaryURL
        self.tclEnvironment = environment
        
        controller.store = self
    }
    
    convenience init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        
        let model = try JSONDecoder().decode(Model.self, from: data)
        self.init(model: model)
    }
}

class SharedStore: ObservableObject {
    var stores: [Store] = []
}
