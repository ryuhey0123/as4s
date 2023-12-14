//
//  Node.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import OpenSeesCoder

final class Node: Renderable, Selectable, Displacementable {
    
    // MARK: General Value
    
    var id: Int
    var position: float3
    
    // MARK: Renderable Value
    
    typealias GeometryType = MVCPointGeometry
    typealias ElementConfigType = Config.node
    
    var geometryTag: UInt32!
    var geometry: GeometryType!
    var labelGeometry: MVCLabelGeometry!
    
    var color: Color = ElementConfigType.color {
        didSet {
            geometry.color = float4(float3(color), 1)
        }
    }
    
    // MARK: Selectable Value
    
    var isSelected: Bool = false {
        didSet { color = isSelected ? ElementConfigType.selectedColor : ElementConfigType.color }
    }
    
    // MARK: Displacementable Value
    
    var dispGeometry: GeometryType!
    var dispLabelGeometry: MVCLabelGeometry!
    
    init(id: Int, position: float3) {
        self.id = id
        self.position = position
        self.geometry =  MVCPointGeometry(position: position, color: .init(ElementConfigType.color))
        self.dispGeometry = MVCPointGeometry(position: position, color: .init(Config.postprocess.dispColor))
        self.labelGeometry = Self.buildLabelGeometry(target: position, tag: nodeTag.description)
        self.geometryTag = geometry.id
    }
    
    func append(model: Model) {
        model.nodes.append(self)
    }
}

extension Node: OSNode {
    
    var nodeTag: Int { id }
    
    var coords: [Float] { position.array }
    
    var massValues: [Float]? { nil }
}


extension Node {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.nodeTag == rhs.nodeTag
    }
}
