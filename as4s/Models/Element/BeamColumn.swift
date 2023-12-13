//
//  Beam.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import SwiftUI
import Mevic
import OpenSeesCoder

final class BeamColumn: OSElasticBeamColumn, Renderable, Selectable {
    
    typealias GeometryType = MVCLineGeometry
    typealias ElementConfigType = Config.beam
    
    // MARK: OpenSees Value
    
    var eleTag: Int
    var secTag: Int
    
    var iNode: Int
    var jNode: Int
    
    var transfTag: Int
    
    var massDens: Float?
    
    // MARK: Renderable Value
    
    var geometryTag: UInt32!
    var geometry: GeometryType!
    var labelGeometry: MVCLabelGeometry!
    
    var color: Color = ElementConfigType.color {
        didSet {
            geometry!.iColor = float4(float3(color), 1)
            geometry!.jColor = float4(float3(color), 1)
        }
    }
    
    var isSelected: Bool = false {
        didSet { color = isSelected ? ElementConfigType.selectedColor : ElementConfigType.color }
    }
    
    init(eleTag: Int, iNode: Int, jNode: Int, secTag: Int = 0, transfTag: Int = 0, massDens: Float? = nil) {
        self.eleTag = eleTag
        self.iNode = iNode
        self.jNode = jNode
        self.secTag = secTag
        self.transfTag = transfTag
        self.massDens = massDens
    }
    
    init(id: Int, i: Node, j: Node) {
        self.eleTag = id
        self.iNode = i.nodeTag
        self.jNode = j.nodeTag
        self.secTag = 0
        self.transfTag = 0
        self.massDens = nil
    }
    
    func geometrySetup(model: Model) {
        guard let i = model.nodes.first(where: { $0.nodeTag == iNode })?.position,
              let j = model.nodes.first(where: { $0.nodeTag == jNode })?.position else {
            fatalError("Cannot find nodes \(iNode), \(jNode)")
        }
        
        self.geometry = MVCLineGeometry(i: i, j: j, iColor: float4(color), jColor: float4(color))
        self.labelGeometry = Self.buildLabelGeometry(target: (i + j) / 2, tag: eleTag.description)
        self.geometryTag = geometry.id
    }
    
    func append(model: Model) {
        model.beams.append(self)
    }
}