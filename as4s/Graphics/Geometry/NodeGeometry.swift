//
//  NodeGeometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

class NodeGeometry: Geometry {
    
    typealias ElementConfigType = Config.node
    
    var model: MVCPointGeometry
    var label: MVCLabelGeometry
    var disp: MVCPointGeometry
    var dispLabel: MVCLabelGeometry
    
    var color: Color = ElementConfigType.color
    
    init(id: Int, position: float3) {
        let position = position.metal
        model = MVCPointGeometry(position: position, color: .init(ElementConfigType.color))
        disp = MVCPointGeometry(position: position, color: .init(Config.postprocess.dispColor))
        label = Self.defaultLabel(target: position, tag: id.description)
        dispLabel = Self.defaultLabel(target: position, tag: id.description)
    }
    
    func update(id: Int, position: float3) {
        let position = position.metal
        model.position = position
        disp.position = position
        label.target = position
        dispLabel.target = position
    }
}
