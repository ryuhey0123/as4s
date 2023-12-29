//
//  ForceBeamColumn.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/29.
//

import Mevic

final class ForceBeamColumn {
    
    weak var beam: BeamColumn!
    
    var geometry: BeamForceGeometry
    
    init(beam: BeamColumn) {
        self.beam = beam
        geometry = .init(i: beam.i.position.metal,
                         j: beam.j.position.metal,
                         zdir: beam.coordVector,
                         ydir: beam.coordCrossVector)
    }
    
    func updateForce(force: [Float]) {
        geometry.updateGeometry(force: force)
    }

}
