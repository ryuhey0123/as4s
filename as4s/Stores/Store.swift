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
    
    let scene: GraphicScene = GraphicScene()
    
    // Model
    let modelLayer: MVCLayer = MVCLayer("Model")
    
    let vXLayer: MVCLayer = MVCLayer("Vx")
    let vYLayer: MVCLayer = MVCLayer("Vy")
    let vZLayer: MVCLayer = MVCLayer("Vz")
    let mXLayer: MVCLayer = MVCLayer("Mx")
    let mYLayer: MVCLayer = MVCLayer("My")
    let mZLayer: MVCLayer = MVCLayer("Mz")
    
    let loadLayer: MVCLayer = MVCLayer("Load")
    
    let captionLayer: MVCLayer = MVCLayer("Caption")
    
    // Label
    let nodeLabelLayer: MVCLayer = MVCLayer("NodeLabel")
    let beamLabelLayer: MVCLayer = MVCLayer("BeamLabel")
    
    let vXLabelLayer: MVCLayer = MVCLayer("VxLabel")
    let vYLabelLayer: MVCLayer = MVCLayer("VyLabel")
    let vZLabelLayer: MVCLayer = MVCLayer("VzLabel")
    let mXLabelLayer: MVCLayer = MVCLayer("MxLabel")
    let mYLabelLayer: MVCLayer = MVCLayer("MyLabel")
    let mZLabelLayer: MVCLayer = MVCLayer("MzLabel")
    
    let loadLabelLayer: MVCLayer = MVCLayer("LoadLabel")
    
    let openSeesBinaryURL: URL
    let tclEnvironment: [String : String]
    
    var openSeesStdOutData: Data?
    var openSeesStdErrData: Data?
    
    init(model: Model = Model()) {
        guard let binaryURL = Bundle.main.url(forResource: "OpenSees", withExtension: nil) else {
            fatalError("Not found OpenSees")
        }
        
        guard let tclURL = Bundle.main.url(forResource: "init.tcl", withExtension: nil) else {
            fatalError("Not found init.tcl")
        }
        
        var environment = ProcessInfo.processInfo.environment
        environment["TCL_LIBRARY"] = tclURL.deletingLastPathComponent().path
        
        // Model
        scene.append(layer: modelLayer)
        scene.append(layer: vXLayer)
        scene.append(layer: vYLayer)
        scene.append(layer: vZLayer)
        scene.append(layer: mXLayer)
        scene.append(layer: mYLayer)
        scene.append(layer: mZLayer)
        scene.append(layer: loadLayer)
        scene.append(layer: captionLayer)
        // Label
        scene.append(layer: nodeLabelLayer)
        scene.append(layer: beamLabelLayer)
        scene.append(layer: vXLabelLayer)
        scene.append(layer: vYLabelLayer)
        scene.append(layer: vZLabelLayer)
        scene.append(layer: mXLabelLayer)
        scene.append(layer: mYLabelLayer)
        scene.append(layer: mZLabelLayer)
        scene.append(layer: loadLabelLayer)
        
        self.model = model
        self.openSeesBinaryURL = binaryURL
        self.tclEnvironment = environment
    }
    
    convenience init(configuration: ReadConfiguration) throws {
//        guard let data = configuration.file.regularFileContents else {
//            throw CocoaError(.fileReadCorruptFile)
//        }
//        
//        let model = try JSONDecoder().decode(Model.self, from: data)
//        self.init(model: model)
        fatalError()
    }
}

class SharedStore: ObservableObject {
    var stores: [Store] = []
}
