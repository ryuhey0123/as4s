//
//  Node.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import OpenSeesCoder

final class Node: OSNode, Renderable, Selectable, Displacementable {
    
    typealias GeometryType = MVCPointGeometry
    typealias ElementConfigType = Config.node
    
    // MARK: OpenSees Value
    
    var nodeTag: Int
    var coords: [Float]
    var massValues: [Float]?
    
    // MARK: Renderable Value
    
    var geometryTag: UInt32!
    var geometry: GeometryType!
    var labelGeometry: MVCLabelGeometry!
    
    var color: Color = ElementConfigType.color {
        didSet {
            geometry.color = float4(float3(color), 1)
        }
    }
    
    var isSelected: Bool = false {
        didSet { color = isSelected ? ElementConfigType.selectedColor : ElementConfigType.color }
    }
    
    // MARK: PostProcess Value
    
    var dispGeometry: GeometryType!
    var dispLabelGeometry: MVCLabelGeometry!
    
    // MARK: Other Value
    
    var position: float3 {
        get { .init(coords) }
        set { coords = newValue.array }
    }
    
    init(nodeTag: Int, coords: [Float], massValues: [Float]? = nil) {
        self.nodeTag = nodeTag
        self.coords = coords
        self.massValues = massValues
        self.geometry =  MVCPointGeometry(position: float3(coords), color: .init(ElementConfigType.color))
        self.dispGeometry = MVCPointGeometry(position: float3(coords), color: .init(Config.postprocess.dispColor))
        self.labelGeometry = Self.buildLabelGeometry(target: float3(coords), tag: nodeTag.description)
        self.geometryTag = geometry.id
    }
    
    convenience init(id: Int, position: float3) {
        self.init(nodeTag: id, coords: position.array)
    }
    
    func geometrySetup(model: Model) {}
    
    func dispGeometrySetup(model: Model) {}
    
    func append(model: Model) {
        model.nodes.append(self)
    }
}

extension Node {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.nodeTag == rhs.nodeTag
    }
}
