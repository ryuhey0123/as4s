//
//  NodalLoadGeometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//
import SwiftUI
import Mevic

struct NodalLoadGeometry: Geometry {
    
    typealias ElementConfigType = Config.nodalLoad
    
    var model: MVCArrowGeometry
    var label: MVCLabelGeometry
    
    var color: Color = ElementConfigType.color {
        didSet {
            model.color = float4(float3(color), 1)
        }
    }
    
    init(id: Int, position: float3, loadvalues: [Float]) {
        let arrowhead = position - float3(loadvalues[0..<3]).metal * 0.01
        let tag = "(\(loadvalues[0] / 1000), \(loadvalues[1] / 1000), \(loadvalues[2] / 1000))"
        model = MVCArrowGeometry(i: arrowhead,
                                 j: position,
                                 color: float3(color),
                                 thickness: 0.01)
        label = Self.defaultLabel(target: arrowhead, tag: tag)
    }
}
