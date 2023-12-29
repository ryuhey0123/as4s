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
    @Published var loadLayer = LoadLayer()
    @Published var captionLayer = CaptionLayer()
    
    @Published var results = MVCLayer("Results")
    
    override init(_ label: String? = nil) {
        super.init()
        buildLayer()
        
        camera.viewSize = 5000
        camera.near = 100_000
        camera.far = -100_000
    }
    
    private func buildLayer() {
        append(layer: modelLayer)
        append(layer: loadLayer)
        append(layer: captionLayer)
        append(layer: results)
    }
}
