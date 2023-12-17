//
//  Beam.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import SwiftUI
import Mevic
import OpenSeesCoder
import simd

final class BeamColumn: Renderable, Selectable {
    
    // MARK: General Value
    
    var id: Int
    var i: Node
    var j: Node
    var chordAngle: Float
    
    var vector: float3 {
        j.position - i.position
    }
    
    var chordVector: float3 {
        vector.chordVector(angle: chordAngle)
    }
    
    var chordCrossVector: float3 {
        cross(chordVector, vector).normalized
    }
    
    // MARK: Renderable Value
    
    typealias ElementConfigType = Config.beam
    
    var geometry: MVCLineGeometry!
    var dispGeometry: MVCLineGeometry!
    
    var axialGeometry: MVCQuadGeometry!
    var shearZGeometry: MVCQuadGeometry!
    var shearYGeometry: MVCQuadGeometry!
    var momentZGeometry: MVCQuadGeometry!
    var momentYGeometry: MVCQuadGeometry!
    
    var labelGeometry: MVCLabelGeometry!
    var dispLabelGeometry: MVCLabelGeometry!
    
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
    
    init(id: Int, i: Node, j: Node, chordAngle: Float = 0.0) {
        self.id = id
        self.i = i
        self.j = j
        self.chordAngle = chordAngle
        
        self.geometry = MVCLineGeometry(i: i.position.metal,
                                        j: j.position.metal,
                                        iColor: float4(color),
                                        jColor: float4(color))
        
        self.dispGeometry = MVCLineGeometry(i: i.position.metal,
                                            j: j.position.metal,
                                            iColor: float4(Config.postprocess.dispColor),
                                            jColor: float4(Config.postprocess.dispColor))
        
        self.labelGeometry = Self.buildLabelGeometry(target: (i.position + j.position).metal / 2,
                                                     tag: id.description)
    }
    
    func appendTo(model: Model) {
        model.beams.append(self)
        model.linerTransfs.append(self.transformation)
    }
    
    func appendTo(scene: GraphicScene) {
        scene.modelLayer.beam.append(geometry: geometry)
        scene.modelLayer.beamLabel.append(geometry: labelGeometry)
        scene.dispModelLayer.beam.append(geometry: dispGeometry)
    }
    
    static func buildForceGeometry(i: float3, j: float3, direction: float3, iForce: Float, jForce: Float, minForce: Float, maxForce: Float) -> MVCTrapezoidGeometry {
        let scale: Float = 0.00005
        
        let forceBand = maxForce - minForce
        let iForceRatio = (iForce - minForce) / forceBand
        let jForceRatio = (jForce - minForce) / forceBand
        
        let minColor = float4(Config.postprocess.minForceColor)
        let maxColor = float4(Config.postprocess.maxForceColor)
        
        let iColor = (maxColor - minColor) * iForceRatio + minColor
        let jColor = (maxColor - minColor) * jForceRatio + minColor
        
        return MVCTrapezoidGeometry(i: i,
                                    j: j,
                                    iHeight: iForce * scale,
                                    jHeight: jForce * scale,
                                    direction: direction,
                                    iColor: iColor,
                                    jColor: jColor)
    }
}

extension BeamColumn: OSElasticBeamColumn {
    
    var eleTag: Int { id }
    
    var secTag: Int { 1 }
    
    var iNode: Int { i.id }
    
    var jNode: Int { j.id }
    
    var transfTag: Int { id }
    
    var massDens: Float? { nil }
    
    var transformation: Transformation {
        Transformation(id: id, vector: chordVector)
    }
}
