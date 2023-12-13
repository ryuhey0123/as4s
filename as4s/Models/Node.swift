//
//  Node.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import OpenSeesCoder

final class Node: OSNode, Renderable, Selectable {
    
    typealias Geometry = MVCPointGeometry
    typealias ElementConfig = Config.node
    
    // MARK: OpenSees Value
    
    var nodeTag: Int
    
    var coords: [Float]
    var massValues: [Float]?
    
    // MARK: Renderable Value
    
    var geometryTag: UInt32!
    var geometry: Geometry!
    var labelGeometry: MVCLabelGeometry!
    
    var position: float3 {
        get { .init(coords) }
        set { coords = newValue.array }
    }
    
    var color: Color = ElementConfig.color {
        didSet {
            geometry.color = float4(float3(color), 1)
        }
    }
    
    var isSelected: Bool = false {
        didSet { color = isSelected ? ElementConfig.selectedColor : ElementConfig.color }
    }
    
    init(nodeTag: Int, coords: [Float], massValues: [Float]? = nil) {
        self.nodeTag = nodeTag
        self.coords = coords
        self.massValues = massValues
        self.geometry =  MVCPointGeometry(position: float3(coords), color: .init(ElementConfig.color))
        self.labelGeometry = Self.buildLabelGeometry(position: float3(coords), tag: nodeTag.description)
        self.geometryTag = geometry.id
    }
    
    init(id: Int, position: float3) {
        self.nodeTag = id
        self.coords = position.array
        self.massValues = nil
        self.geometry =  MVCPointGeometry(position: float3(coords), color: .init(ElementConfig.color))
        self.labelGeometry = Self.buildLabelGeometry(position: float3(coords), tag: nodeTag.description)
        self.geometryTag = geometry.id
    }
    
    func geometrySetup(model: Model) {}
    
    func append(model: Model) {
        model.nodes.append(self)
    }
}

extension Node {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.nodeTag == rhs.nodeTag
    }
}
