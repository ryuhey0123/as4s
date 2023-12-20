//
//  BeamGeometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

struct BeamGeometry: Geometry {
    
    typealias ElementConfigType = Config.beam
    
    enum Force: Int {
        static let offset = 6
        case P = 0
        case Mz = 1
        case Vy = 2
        case My = 3
        case Vz = 4
        case T = 5
    }
    
    var color: Color = ElementConfigType.color {
        didSet {
            model.iColor = float4(float3(color), 1)
            model.jColor = float4(float3(color), 1)
        }
    }
    
    var model: RFLine
    var label: MVCLabelGeometry
    
    var disp: MVCLineGeometry
    
    var vX: RFTrapezoid
    var vY: MVCTrapezoidGeometry
    var vZ: MVCTrapezoidGeometry
    var mX: MVCTrapezoidGeometry
    var mY: MVCTrapezoidGeometry
    var mZ: MVCTrapezoidGeometry
    
    var vXiLabel: MVCLabelGeometry
    var vYiLabel: MVCLabelGeometry
    var vZiLabel: MVCLabelGeometry
    var mXiLabel: MVCLabelGeometry
    var mYiLabel: MVCLabelGeometry
    var mZiLabel: MVCLabelGeometry
    var vXjLabel: MVCLabelGeometry
    var vYjLabel: MVCLabelGeometry
    var vZjLabel: MVCLabelGeometry
    var mXjLabel: MVCLabelGeometry
    var mYjLabel: MVCLabelGeometry
    var mZjLabel: MVCLabelGeometry
    
    func updateI(i: float3, j: float3) {
        model.i = i
        label.target = (i + j) / 2
        disp.i = i
        vX.i = i
        vY.i = i
        vZ.i = i
        mX.i = i
        mY.i = i
        mZ.i = i
        vXiLabel.target = i
        vYiLabel.target = i
        vZiLabel.target = i
        mXiLabel.target = i
        mYiLabel.target = i
        mZiLabel.target = i
    }
    
    func updateJ(i: float3, j: float3) {
        model.j = j
        label.target = (i + j) / 2
        disp.j = j
        vX.j = j
        vY.j = j
        vZ.j = j
        mX.j = j
        mY.j = j
        mZ.j = j
        vXjLabel.target = j
        vYjLabel.target = j
        vZjLabel.target = j
        mXjLabel.target = j
        mYjLabel.target = j
        mZjLabel.target = j
    }
    
    init(id: Int, i: Node, j: Node, zdir: float3, ydir: float3) {
        
        model = RFLine(i: i, j: j, color: ElementConfigType.color, selectable: true)
        
        let i = i.position.metal
        let j = j.position.metal
        
        label = Self.defaultLabel(target: (i + j) / 2, tag: id.description)
        disp = MVCLineGeometry(i: i, j: j, iColor: float4(color), jColor: float4(color))
        
        vX = RFTrapezoid(line: model, iColor: .red, jColor: .blue, direction: .z)
        vY = Self.defalutGeometry(i: i, j: j, direction: ydir)
        vZ = Self.defalutGeometry(i: i, j: j, direction: zdir)
        mX = Self.defalutGeometry(i: i, j: j, direction: zdir)
        mY = Self.defalutGeometry(i: i, j: j, direction: zdir)
        mZ = Self.defalutGeometry(i: i, j: j, direction: ydir)
        
        vXiLabel = Self.defaultLabel(target: i)
        vYiLabel = Self.defaultLabel(target: i)
        vZiLabel = Self.defaultLabel(target: i)
        mXiLabel = Self.defaultLabel(target: i)
        mYiLabel = Self.defaultLabel(target: i)
        mZiLabel = Self.defaultLabel(target: i)
        vXjLabel = Self.defaultLabel(target: j)
        vYjLabel = Self.defaultLabel(target: j)
        vZjLabel = Self.defaultLabel(target: j)
        mXjLabel = Self.defaultLabel(target: j)
        mYjLabel = Self.defaultLabel(target: j)
        mZjLabel = Self.defaultLabel(target: j)
    }
    
    static func defalutGeometry(i: float3, j: float3, direction: float3) -> MVCTrapezoidGeometry {
        MVCTrapezoidGeometry(i: i,
                             j: j,
                             iHeight: 0,
                             jHeight: 0,
                             direction: direction,
                             iColor: float4(Config.postprocess.minForceColor),
                             jColor: float4(Config.postprocess.maxForceColor))
    }
    
    mutating func updateGeometry(force: [Float]) {
        let offset = Force.offset
        
        var vScale: Float = 0.05
        var mScale: Float = 0.00005
        
        let vXi = -force[Force.P.rawValue]
        let vYi = -force[Force.Vy.rawValue]
        let vZi = -force[Force.Vz.rawValue]
        let mXi = -force[Force.T.rawValue]
        let mYi = -force[Force.My.rawValue]
        let mZi = force[Force.Mz.rawValue]
        let vXj = force[Force.P.rawValue + offset]
        let vYj = force[Force.Vy.rawValue + offset]
        let vZj = force[Force.Vz.rawValue + offset]
        let mXj = force[Force.T.rawValue + offset]
        let mYj = force[Force.My.rawValue + offset]
        let mZj = -force[Force.Mz.rawValue + offset]
        
        
        vX.iHeight = vXi * vScale
        vY.iHeight = vYi * vScale
        vZ.iHeight = vZi * vScale
        mX.iHeight = mXi * mScale
        mY.iHeight = mYi * mScale
        mZ.iHeight = mZi * mScale
        vX.jHeight = vXj * vScale
        vY.jHeight = vYj * vScale
        vZ.jHeight = vZj * vScale
        mX.jHeight = mXj * mScale
        mY.jHeight = mYj * mScale
        mZ.jHeight = mZj * mScale
        
        vScale = 0.001
        mScale = 0.00001
        
        vXiLabel.text = String(format: "%.1f", vXi * vScale)
        vYiLabel.text = String(format: "%.1f", vYi * vScale)
        vZiLabel.text = String(format: "%.1f", vZi * vScale)
        mXiLabel.text = String(format: "%.1f", mXi * mScale)
        mYiLabel.text = String(format: "%.1f", mYi * mScale)
        mZiLabel.text = String(format: "%.1f", mZi * mScale)
        vXjLabel.text = String(format: "%.1f", vXj * vScale)
        vYjLabel.text = String(format: "%.1f", vYj * vScale)
        vZjLabel.text = String(format: "%.1f", vZj * vScale)
        mXjLabel.text = String(format: "%.1f", mXj * mScale)
        mYjLabel.text = String(format: "%.1f", mYj * mScale)
        mZjLabel.text = String(format: "%.1f", mZj * mScale)
        
        vXiLabel.target = vX.k
        vYiLabel.target = vY.k
        vZiLabel.target = vZ.k
        mXiLabel.target = mX.k
        mYiLabel.target = mY.k
        mZiLabel.target = mZ.k
        vXjLabel.target = vX.l
        vYjLabel.target = vY.l
        vZjLabel.target = vZ.l
        mXjLabel.target = mX.l
        mYjLabel.target = mY.l
        mZjLabel.target = mZ.l
    }
}
