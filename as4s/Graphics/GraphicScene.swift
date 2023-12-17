//
//  GraphicScene.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import SwiftUI
import Mevic

class GraphicScene: MVCScene, ObservableObject {
    
    // MARK: Model Layer
    
    let modelLayer: MVCLayer = MVCLayer("Model")
    
    let vXLayer: MVCLayer = MVCLayer("Vx")
    let vYLayer: MVCLayer = MVCLayer("Vy")
    let vZLayer: MVCLayer = MVCLayer("Vz")
    let mXLayer: MVCLayer = MVCLayer("Mx")
    let mYLayer: MVCLayer = MVCLayer("My")
    let mZLayer: MVCLayer = MVCLayer("Mz")
    
    let loadLayer: MVCLayer = MVCLayer("Load")
    
    let captionLayer: MVCLayer = MVCLayer("Caption")
    
    // MARK: Label Layer
    
    let nodeLabelLayer: MVCLayer = MVCLayer("NodeLabel")
    let beamLabelLayer: MVCLayer = MVCLayer("BeamLabel")
    
    let vXLabelLayer: MVCLayer = MVCLayer("VxLabel")
    let vYLabelLayer: MVCLayer = MVCLayer("VyLabel")
    let vZLabelLayer: MVCLayer = MVCLayer("VzLabel")
    let mXLabelLayer: MVCLayer = MVCLayer("MxLabel")
    let mYLabelLayer: MVCLayer = MVCLayer("MyLabel")
    let mZLabelLayer: MVCLayer = MVCLayer("MzLabel")
    
    let loadLabelLayer: MVCLayer = MVCLayer("LoadLabel")
    
    @Published var nodeLabelVisiable: Bool = true {
        didSet { nodeLabelLayer.isHidden = !nodeLabelVisiable }
    }
    
    override init(_ label: String? = nil) {
        super.init()
        buildLayer()
        
        camera.viewSize = 5000
        camera.near = 100_000
        camera.far = -100_000
    }
    
    func buildLayer() {
        // Model
        append(layer: modelLayer)
        append(layer: vXLayer)
        append(layer: vYLayer)
        append(layer: vZLayer)
        append(layer: mXLayer)
        append(layer: mYLayer)
        append(layer: mZLayer)
        append(layer: loadLayer)
        append(layer: captionLayer)
        // Label
        append(layer: nodeLabelLayer)
        append(layer: beamLabelLayer)
        append(layer: vXLabelLayer)
        append(layer: vYLabelLayer)
        append(layer: vZLabelLayer)
        append(layer: mXLabelLayer)
        append(layer: mYLabelLayer)
        append(layer: mZLabelLayer)
        append(layer: loadLabelLayer)
    }
}
