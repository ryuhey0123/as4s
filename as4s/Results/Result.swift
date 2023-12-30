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
    
    var disp: DispModel
    var forceBeams: [ForceBeamColumn] = []
    
    init(label: String) {
        self.label = label
        disp = DispModel()
    }
    
    func appendTo(scene: GraphicScene) {
        var layer = ResultLayer()
        
        disp.appendTo(layer: &layer, update: false)
        
        forceBeams.forEach {
            layer.beamForce.append(forceGeometry: $0.geometry, update: false)
        }
        
        layer.update()
        scene.results.append(layer: layer)
    }
}
