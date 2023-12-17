//
//  GraphicScene.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import SwiftUI
import Mevic

class GraphicScene: MVCScene, ObservableObject {
    
    @Published var modelLayer = ModelLayer()
    @Published var dispModelLayer = ModelLayer()
    let forceLayer = ForceLayer()
    let loadLayer = LoadLayer()
    let captionLayer = CaptionLayer()
    
    @Published var modelVisiable: Bool = true {
        didSet { modelLayer.isHidden = !modelVisiable }
    }
    
    override init(_ label: String? = nil) {
        super.init()
        buildLayer()
        
        camera.viewSize = 5000
        camera.near = 100_000
        camera.far = -100_000
    }
    
    func buildLayer() {
        append(layer: modelLayer)
        append(layer: forceLayer)
        append(layer: loadLayer)
        append(layer: captionLayer)
    }
}
