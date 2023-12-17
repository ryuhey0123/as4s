//
//  NodalLoadGeometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//
import SwiftUI
import Mevic

struct NodalLoadGeometry {
    
    typealias ElementConfigType = Config.nodalLoad
    
    var model: MVCArrowGeometry
    var label: MVCLabelGeometry
    
    var color: Color = ElementConfigType.color
    
    init(id: Int, position: float3, loadvalues: [Float]) {
        let arrowhead = position.metal - float3(loadvalues[0..<3]).metal * 0.01
        let tag = "(\(loadvalues[0] / 1000), \(loadvalues[1] / 1000), \(loadvalues[2] / 1000))"
        model = MVCArrowGeometry(i: arrowhead,
                                 j: position.metal,
                                 color: float3(color),
                                 thickness: 0.01)
        label = Self.buildLabelGeometry(target: arrowhead, tag: tag)
    }
    
    static func buildLabelGeometry(target: float3, tag: String) -> MVCLabelGeometry {
        MVCLabelGeometry(target: target,
                         text: tag,
                         forgroundColor: .init(ElementConfigType.labelColor),
                         backgroundColor: .init(ElementConfigType.labelBgColor),
                         margin: .init(ElementConfigType.labelPaddingX, ElementConfigType.labelPaddingY),
                         alignment: ElementConfigType.labelAlignment
        )
    }
}
