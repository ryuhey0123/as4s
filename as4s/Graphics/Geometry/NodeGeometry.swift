//
//  NodeGeometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

struct NodeGeometry {
    
    typealias ElementConfigType = Config.node
    
    var model: MVCPointGeometry
    var label: MVCLabelGeometry
    var disp: MVCPointGeometry
    var dispLabel: MVCLabelGeometry
    
    var color: Color = ElementConfigType.color {
        didSet {
            model.color = float4(float3(color), 1)
        }
    }
    
    init(id: Int, position: float3) {
        model =  MVCPointGeometry(position: position, color: .init(ElementConfigType.color))
        disp = MVCPointGeometry(position: position, color: .init(Config.postprocess.dispColor))
        label = Self.buildLabelGeometry(target: position, tag: id.description)
        dispLabel = Self.buildLabelGeometry(target: position, tag: id.description)
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
