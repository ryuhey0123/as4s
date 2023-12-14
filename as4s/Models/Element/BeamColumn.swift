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
        
        self.vector = (j.position - i.position).normalized
        self.chordAngle = chordAngle
        self.chordVector = (Self.calcCoordTransMatrix(vector: vector, angle: chordAngle) * vector).normalized
        self.chordCrossVector = cross(chordVector, vector)
        self.transformation = Transformation(id: id, vector: chordVector)
    }
    
    func append(model: Model) {
        model.beams.append(self)
        model.linerTransfs.append(self.transformation)
    }
    
    static func calcCoordTransMatrix(vector: float3, angle: Float) -> float3x3 {
        let dd = vector
        let len = length(vector)
        let ll = dd.x / len
        let mm = dd.y / len
        let nn = dd.z / len
        let qq = sqrt(pow(ll, 2) + pow(mm, 2))
        
        let t1 = float3x3(rows: [
            float3([1,           0,          0]),
            float3([0,  cos(angle), sin(angle)]),
            float3([0, -sin(angle), cos(angle)])
        ])
        
        var t2 = float3x3()
        
        let t3 = float3x3(rows: [
            float3([ 0, 0, 1]),
            float3([ 0, 1, 0]),
            float3([-1, 0, 0])
        ])
        
        if dd.x == 0.0 && dd.y == 0.0 {
            t2 = float3x3(rows: [
                float3([ 0, 0, nn]),
                float3([nn, 0,  0]),
                float3([ 0, 1,  0])
            ])
        } else {
            t2 = float3x3(rows: [
                float3([       ll,        mm, nn]),
                float3([   -mm/qq,     ll/qq,  0]),
                float3([-ll*nn/qq, -mm*nn/qq, qq])
            ]) * t3
        }
        
        return t1 * t2
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
