//
//  NodeGeometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

struct NodeGeometry: Geometry {
    typealias ElementConfigType = Config.node
    
    var model: MVCPointGeometry
    var label: MVCLabelGeometry
    
    var color: Color = ElementConfigType.color {
        didSet {
            model.color = float4(float3(color), 1)
        }
    }
    
    init(id: Int, position: float3) {
        let position = position.metal
        model = MVCPointGeometry(position: position, color: .init(ElementConfigType.color))
        label = Self.defaultLabel(target: position, tag: id.description)
    }
    
    mutating func update(id: Int, position: float3) {
        let position = position.metal
        model.position = position
        label.target = position
    }
}
