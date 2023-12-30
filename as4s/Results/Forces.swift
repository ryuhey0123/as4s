//
//  Forces.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/30.
//

import Foundation

final class Forces {
    var columnBeams: [ForceBeamColumn] = []
    
    func appendTo(layer: inout ResultLayer, update: Bool) {
        columnBeams.forEach {
            layer.beamForce.append(forceGeometry: $0.geometry, update: update)
        }
    }
}
