//
//  AS4Beam.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import Mevic

final class AS4Beam: AS4Element<MVCLineGeometry, AS4Config.beam> {
    
    typealias Config = AS4Config.beam
    typealias Geometry = MVCLineGeometry
    
    var i: double3
    var j: double3
    
    init(id: Int, i: double3, j: double3) {
        self.i = i
        self.j = j
        
        let geometry = MVCLineGeometry(i: float3(i), j: float3(j), color: .init(Config.color))
        let idLabel = MVCLabelGeometry(target: float3((i + j) / 2), text: String(id), margin: .zero)
        
        super.init(id: id, geometry: geometry, idLabel: idLabel)
    }
}
