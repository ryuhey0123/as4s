//
//  Store.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

final class Store {
    
    var model: Model
    
    let scene = GameScene()
    
    var modelLayer: MVCLayer!
    var captionLayer: MVCLayer!
    
    var nodeLabelLayer: MVCLayer!
    var beamLabelLayer: MVCLayer!
    
    let controller: GraphicController
    
    let openSeesURL: URL
    let tclEnvironment: [String : String]
    
    init(model: Model = Model()) {
        controller = GraphicController(scene: scene)
        self.model = model
        
        guard let binaryURL = Bundle.main.url(forResource: "OpenSees", withExtension: nil) else {
            fatalError("Not found OpenSees")
        }
        self.openSeesURL = binaryURL
        
        guard let tclURL = Bundle.main.url(forResource: "init.tcl", withExtension: nil) else {
            fatalError("Not found init.tcl")
        }
        
        var environment = ProcessInfo.processInfo.environment
        environment["TCL_LIBRARY"] = tclURL.deletingLastPathComponent().path
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
