//
//  Result.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/29.
//

import Foundation

final class Result: Identifiable {
    
    var id = UUID()
    var label: String
    
    var dispNodes: [DispNode] = []
    var dispBeams: [DispBeamColumn] = []
    
    var forceBeams: [ForceBeamColumn] = []
    
    init(label: String) {
        self.label = label
    }
    
    func appendTo(scene: GraphicScene) {
        let layer = ResultLayer()
        
        dispNodes.forEach {
            layer.nodeDisp.append(geometry: $0.geometry.model, update: false)
        }
        
        dispBeams.forEach {
            layer.beamDisp.append(geometry: $0.geometry.model, update: false)
        }
        
        forceBeams.forEach {
            layer.beamForce.append(forceGeometry: $0.geometry, update: false)
        }
        
        layer.update()
        scene.results.append(layer: layer)
    }
}
