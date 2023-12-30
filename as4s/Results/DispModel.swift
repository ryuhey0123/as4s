//
//  DispModel.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/30.
//

final class DispModel {
    
    var nodes: [DispNode] = []
    var beams: [DispBeamColumn] = []
    
    init() {}
    
    func appendTo(layer: inout ResultLayer, update: Bool) {
        nodes.forEach {
            layer.disp.node.append(geometry: $0.geometry.model, update: update)
        }
        beams.forEach {
            layer.disp.beam.append(geometry: $0.geometry.model, update: update)
        }
    }
}
