//
//  Beam.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import SwiftUI
import Mevic
import OpenSeesCoder

final class BeamColumn: Renderable, Selectable, Displacementable {
    
    // MARK: General Value
    
    var id: Int
    var i: Node
    var j: Node
    
    // MARK: Renderable Value
    
    typealias GeometryType = MVCLineGeometry
    typealias ElementConfigType = Config.beam
    
    var geometry: GeometryType!
    var labelGeometry: MVCLabelGeometry!
    
    var color: Color = ElementConfigType.color {
        didSet {
            geometry!.iColor = float4(float3(color), 1)
            geometry!.jColor = float4(float3(color), 1)
        }
    }
    
    // MARK: Selectable Value
    
    var isSelected: Bool = false {
        didSet { color = isSelected ? ElementConfigType.selectedColor : ElementConfigType.color }
    }
    
    // MARK: Displacementable Value
    
    var dispGeometry: GeometryType!
    var dispLabelGeometry: MVCLabelGeometry!
    
    init(id: Int, i: Node, j: Node) {
        self.id = id
        self.i = i
        self.j = j
        self.geometry = MVCLineGeometry(i: i.position,
                                        j: j.position,
                                        iColor: float4(color),
                                        jColor: float4(color))
        self.dispGeometry = MVCLineGeometry(i: i.position,
                                            j: j.position,
                                            iColor: float4(Config.postprocess.dispColor),
                                            jColor: float4(Config.postprocess.dispColor))
        self.labelGeometry = Self.buildLabelGeometry(target: (i.position + j.position) / 2,
                                                     tag: eleTag.description)
    }
    
    func append(model: Model) {
        model.beams.append(self)
    }
}

extension BeamColumn: OSElasticBeamColumn {
    
    var eleTag: Int { id }
    
    var secTag: Int { 1 }
    
    var iNode: Int { i.id }
    
    var jNode: Int { j.id }
    
    var transfTag: Int { 1 }
    
    var massDens: Float? { nil }
}
