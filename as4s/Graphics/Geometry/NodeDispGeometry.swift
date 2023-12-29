//
//  NodeDispGeometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/29.
//

import Mevic

struct NodeDispGeometry: Geometry {
    typealias ElementConfigType = Config.node
    
    static let scale: Float = 100.0
    
    var model: MVCPointGeometry
    var label: MVCLabelGeometry
    
    init(position: float3, disp: float3) {
        let position = (position + disp * Self.scale).metal
        model = .init(position: position, color: .init(.red))
        label = Self.defaultLabel(target: position)
    }}
