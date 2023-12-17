//
//  BeamForceGeometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import Mevic

struct BeamForceGeometry {
    
    enum Force: Int {
        static let offset = 6
        
        case P = 0
        case Mz = 1
        case Vy = 2
        case My = 3
        case Vz = 4
        case T = 5
    }
    
    static let iColor = Config.postprocess.minForceColor
    static let jColor = Config.postprocess.maxForceColor
    
    var vX: MVCTrapezoidGeometry
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
    
    init(i: float3, j: float3, zdir: float3, ydir: float3) {
        vX = Self.defalutGeometry(i: i, j: j, direction: zdir)
        vY = Self.defalutGeometry(i: i, j: j, direction: ydir)
        vZ = Self.defalutGeometry(i: i, j: j, direction: zdir)
        mX = Self.defalutGeometry(i: i, j: j, direction: zdir)
        mY = Self.defalutGeometry(i: i, j: j, direction: zdir)
        mZ = Self.defalutGeometry(i: i, j: j, direction: ydir)
        vXiLabel = Self.defalutLabelGeometry(target: i)
        vYiLabel = Self.defalutLabelGeometry(target: i)
        vZiLabel = Self.defalutLabelGeometry(target: i)
        mXiLabel = Self.defalutLabelGeometry(target: i)
        mYiLabel = Self.defalutLabelGeometry(target: i)
        mZiLabel = Self.defalutLabelGeometry(target: i)
        vXjLabel = Self.defalutLabelGeometry(target: j)
        vYjLabel = Self.defalutLabelGeometry(target: j)
        vZjLabel = Self.defalutLabelGeometry(target: j)
        mXjLabel = Self.defalutLabelGeometry(target: j)
        mYjLabel = Self.defalutLabelGeometry(target: j)
        mZjLabel = Self.defalutLabelGeometry(target: j)
    }
    
    static func defalutGeometry(i: float3, j: float3, direction: float3) -> MVCTrapezoidGeometry {
        MVCTrapezoidGeometry(i: i,
                             j: j,
                             iHeight: 0,
                             jHeight: 0,
                             direction: direction,
                             iColor: float4(Self.iColor),
                             jColor: float4(Self.jColor))
    }
    
    static func defalutLabelGeometry(target: float3) -> MVCLabelGeometry {
        MVCLabelGeometry(target: target, text: "0", alignment: .center)
    }
    
    mutating func updateGeometry(force: [Float]) {
        let offset = Force.offset
        
        var vScale: Float = 0.05
        var mScale: Float = 0.00005
        
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
        
        vScale = 0.001
        mScale = 0.00001
        
        vXiLabel.text = String(format: "%.1f", force[Force.P.rawValue] * vScale)
        vYiLabel.text = String(format: "%.1f", -force[Force.P.rawValue + offset] * vScale)
        vZiLabel.text = String(format: "%.1f", -force[Force.Vy.rawValue] * vScale)
        mXiLabel.text = String(format: "%.1f", force[Force.Vy.rawValue + offset] * vScale)
        mYiLabel.text = String(format: "%.1f", -force[Force.Vz.rawValue] * vScale)
        mZiLabel.text = String(format: "%.1f", force[Force.Vz.rawValue + offset] * vScale)
        vXjLabel.text = String(format: "%.1f", -force[Force.T.rawValue] * mScale)
        vYjLabel.text = String(format: "%.1f", force[Force.T.rawValue + offset] * mScale)
        vZjLabel.text = String(format: "%.1f", -force[Force.My.rawValue] * mScale)
        mXjLabel.text = String(format: "%.1f", force[Force.My.rawValue + offset] * mScale)
        mYjLabel.text = String(format: "%.1f", force[Force.Mz.rawValue] * mScale)
        mZjLabel.text = String(format: "%.1f", -force[Force.Mz.rawValue + offset] * mScale)
        
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
