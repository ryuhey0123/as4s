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
    
    var disp: DispModel = DispModel()
    var forces: ForceModel = ForceModel()
    
    init(label: String) {
        self.label = label
    }
    
    func appendTo(scene: GraphicScene) {
        var layer = ResultLayer(label)
        disp.appendTo(layer: &layer, update: false)
        forces.appendTo(layer: &layer, update: false)
        layer.update()
        
        scene.append(result: layer)
    }
}
