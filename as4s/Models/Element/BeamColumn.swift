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

struct BeamForceGeometry {
    var vX: MVCTrapezoidGeometry
    var vY: MVCTrapezoidGeometry
    var vZ: MVCTrapezoidGeometry
    var mX: MVCTrapezoidGeometry
    var mY: MVCTrapezoidGeometry
    var mZ: MVCTrapezoidGeometry
    
    enum Force: Int {
        case P = 0
        case Mz = 1
        case Vy = 2
        case My = 3
        case Vz = 4
        case T = 5
    }
    
    init(i: float3, j: float3, zdir: float3, ydir: float3, iColor: float4, jColor: float4) {
        vX = Self.defalutGeometry(i: i, j: j, direction: zdir, iColor: iColor, jColor: jColor)
        vY = Self.defalutGeometry(i: i, j: j, direction: ydir, iColor: iColor, jColor: jColor)
        vZ = Self.defalutGeometry(i: i, j: j, direction: zdir, iColor: iColor, jColor: jColor)
        mX = Self.defalutGeometry(i: i, j: j, direction: zdir, iColor: iColor, jColor: jColor)
        mY = Self.defalutGeometry(i: i, j: j, direction: zdir, iColor: iColor, jColor: jColor)
        mZ = Self.defalutGeometry(i: i, j: j, direction: ydir, iColor: iColor, jColor: jColor)
    }
    
    static func defalutGeometry(i: float3, j: float3,
                                direction: float3,
                                iColor: float4, jColor: float4) -> MVCTrapezoidGeometry {
        MVCTrapezoidGeometry(i: i, j: j,
                             iHeight: 0, jHeight: 0,
                             direction: direction,
                             iColor: iColor, jColor: jColor)
    }
    
    mutating func updateGeometry(force: [Float]) {
        let vScale: Float = 0.05
        let mScale: Float = 0.00005
        let offset = 6
        
        vX.iHeight = force[Force.P.rawValue] * vScale
        vX.jHeight = -force[Force.P.rawValue + offset] * vScale
        
        vY.iHeight = -force[Force.Vy.rawValue] * vScale
        vY.jHeight = force[Force.Vy.rawValue + offset] * vScale
        
        vZ.iHeight = -force[Force.Vz.rawValue] * vScale
        vZ.jHeight = force[Force.Vz.rawValue + offset] * vScale
        
        mX.iHeight = -force[Force.T.rawValue] * mScale
        mX.jHeight = force[Force.T.rawValue + offset] * mScale
        
        mY.iHeight = -force[Force.My.rawValue] * mScale
        mY.jHeight = force[Force.My.rawValue + offset] * mScale
        
        mZ.iHeight = force[Force.Mz.rawValue] * mScale
        mZ.jHeight = -force[Force.Mz.rawValue + offset] * mScale
    }
}

struct BeamForceLabelGeometry {
    var vXi: MVCLabelGeometry
    var vYi: MVCLabelGeometry
    var vZi: MVCLabelGeometry
    var mXi: MVCLabelGeometry
    var mYi: MVCLabelGeometry
    var mZi: MVCLabelGeometry
    var vXj: MVCLabelGeometry
    var vYj: MVCLabelGeometry
    var vZj: MVCLabelGeometry
    var mXj: MVCLabelGeometry
    var mYj: MVCLabelGeometry
    var mZj: MVCLabelGeometry
}

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
    var labelGeometry: MVCLabelGeometry!
    
    var dispGeometry: MVCLineGeometry!
    var dispLabelGeometry: MVCLabelGeometry!
    
    var forceGeometry: BeamForceGeometry!
    var forceLabelGeometry: BeamForceLabelGeometry!
    
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
        
        self.forceGeometry = BeamForceGeometry(i: i.position.metal,
                                               j: j.position.metal,
                                               zdir: chordVector.metal,
                                               ydir: chordCrossVector.metal,
                                               iColor: float4(Config.postprocess.minForceColor),
                                               jColor: float4(Config.postprocess.maxForceColor))
    }
    
    func appendTo(model: Model) {
        model.beams.append(self)
        model.linerTransfs.append(self.transformation)
    }
    
    func appendTo(scene: GraphicScene) {
        scene.modelLayer.beam.append(geometry: geometry)
        scene.modelLayer.beamLabel.append(geometry: labelGeometry)
        scene.dispModelLayer.beam.append(geometry: dispGeometry)
        
        scene.forceLayer.append(forceGeometry: forceGeometry)
//        scene.forceLayer.append(forceLabelGeometry: forceLabelGeometry)
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
