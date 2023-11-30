//
//  AS4Beam.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import SwiftUI
import Mevic

final class AS4Beam: AS4Element<MVCLineGeometry, AS4Config.beam> {
    
    typealias Config = AS4Config.beam
    typealias Geometry = MVCLineGeometry
    
    var i: double3
    var j: double3
    
    override var color: Color {
        didSet {
            geometry.iColor = float4(float3(color), 1)
            geometry.jColor = float4(float3(color), 1)
        }
    }
    
    init(id: Int, i: double3, j: double3) {
        self.i = i
        self.j = j
        
        let geometry = MVCLineGeometry(i: float3(i), j: float3(j), color: .init(Config.color))
        let idLabel = MVCLabelGeometry(target: float3((i + j) / 2), text: String(id))
        
        super.init(id: id, geometryId: geometry.id, geometry: geometry, idLabel: idLabel)
    }
}
