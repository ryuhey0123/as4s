//
//  BeamDispGeometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/29.
//

import Mevic

struct BeamDispGeometry: Geometry {
    typealias ElementConfigType = Config.beam
    
    static let scale: Float = 100.0
    
    var model: MVCLineGeometry
    
    init(i: float3, j: float3) {
        model = MVCLineGeometry(i: i, j: j, iColor: float4(.red), jColor: float4(.red))
    }
}
