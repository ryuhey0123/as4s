//
//  ForceLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

class ForceLayer: MVCLayer {
    
    var vX: MVCLayer = MVCLayer("Force-Vx") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var vY: MVCLayer = MVCLayer("Force-Vy") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var vZ: MVCLayer = MVCLayer("Force-Vz") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var mX: MVCLayer = MVCLayer("Force-Mx") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var mY: MVCLayer = MVCLayer("Force-My") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var mZ: MVCLayer = MVCLayer("Force-Mz") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    init() {
        super.init("Model")
        append(layer: vX)
        append(layer: vY)
        append(layer: vZ)
        append(layer: mZ)
        append(layer: mX)
        append(layer: mY)
        
        vX.isShown = false
        vY.isShown = false
        vZ.isShown = false
        mX.isShown = false
        mY.isShown = false
        mZ.isShown = false
    }
    
    func append(forceGeometry: BeamGeometry) {
        vX.append(geometry: forceGeometry.vX)
        vY.append(geometry: forceGeometry.vY)
        vZ.append(geometry: forceGeometry.vZ)
        mX.append(geometry: forceGeometry.mX)
        mY.append(geometry: forceGeometry.mY)
        mZ.append(geometry: forceGeometry.mZ)
        
        vX.append(geometry: forceGeometry.vXiLabel)
        vY.append(geometry: forceGeometry.vYiLabel)
        vZ.append(geometry: forceGeometry.vZiLabel)
        mX.append(geometry: forceGeometry.mXiLabel)
        mY.append(geometry: forceGeometry.mYiLabel)
        mZ.append(geometry: forceGeometry.mZiLabel)
        vX.append(geometry: forceGeometry.vXjLabel)
        vY.append(geometry: forceGeometry.vYjLabel)
        vZ.append(geometry: forceGeometry.vZjLabel)
        mX.append(geometry: forceGeometry.mXjLabel)
        mY.append(geometry: forceGeometry.mYjLabel)
        mZ.append(geometry: forceGeometry.mZjLabel)
    }
}
