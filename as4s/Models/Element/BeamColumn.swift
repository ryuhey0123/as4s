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

final class BeamColumn: Renderable, Selectable, Displacementable, BeamForcable {
    
    // MARK: General Value
    
    var id: Int
    var i: Node
    var j: Node
    
    var vector: float3
    var chordAngle: Float
    var chordVector: float3
    var chordCrossVector: float3
    
    var transformation: Transformation
    
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
    
    // MARK: Foecable Value
    
    var axialGeometry: MVCQuadGeometry!
    var shearZGeometry: MVCQuadGeometry!
    var shearYGeometry: MVCQuadGeometry!
    var momentZGeometry: MVCQuadGeometry!
    var momentYGeometry: MVCQuadGeometry!
    
    init(id: Int, i: Node, j: Node, chordAngle: Float = 0.0) {
        self.id = id
        self.i = i
        self.j = j
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
        
        self.vector = (j.position - i.position)
        self.chordAngle = chordAngle
        self.chordVector = Self.buildChordVecror(vector: vector, angle: chordAngle)
        self.chordCrossVector = cross(chordVector, vector).normalized
        self.transformation = Transformation(id: id, vector: chordVector)
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
    
    static func buildChordVecror(vector: float3, angle: Float) -> float3 {
        guard vector != .zero else {
            fatalError("Error: vector is zero length.")
        }
        
        let rotateMatrix = float4x4.rotation(radians: angle, axis: vector)
        
        var crossVector: float4 = .zero
        if vector.z == 0 {
            crossVector = .init(0, 0, -1, 1)
        } else if vector.x == 0 && vector.y == 0 {
            crossVector = .init(1, 0, 0, 1)
        } else {
            crossVector = .init(vector.x, vector.y, -(pow(vector.x, 2) + pow(vector.y, 2)) / vector.z, 1)
        }
        
        let rotatedVector = rotateMatrix * crossVector
        return rotatedVector.xyz.normalized
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
}
