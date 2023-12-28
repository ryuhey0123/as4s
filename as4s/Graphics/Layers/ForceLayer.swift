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
    
    func append(forceGeometry: BeamGeometry, update: Bool = true) {
        vX.append(geometry: forceGeometry.vX, update: update)
        vY.append(geometry: forceGeometry.vY, update: update)
        vZ.append(geometry: forceGeometry.vZ, update: update)
        mX.append(geometry: forceGeometry.mX, update: update)
        mY.append(geometry: forceGeometry.mY, update: update)
        mZ.append(geometry: forceGeometry.mZ, update: update)
        
        vX.append(geometry: forceGeometry.vXiLabel, update: update)
        vY.append(geometry: forceGeometry.vYiLabel, update: update)
        vZ.append(geometry: forceGeometry.vZiLabel, update: update)
        mX.append(geometry: forceGeometry.mXiLabel, update: update)
        mY.append(geometry: forceGeometry.mYiLabel, update: update)
        mZ.append(geometry: forceGeometry.mZiLabel, update: update)
        vX.append(geometry: forceGeometry.vXjLabel, update: update)
        vY.append(geometry: forceGeometry.vYjLabel, update: update)
        vZ.append(geometry: forceGeometry.vZjLabel, update: update)
        mX.append(geometry: forceGeometry.mXjLabel, update: update)
        mY.append(geometry: forceGeometry.mYjLabel, update: update)
        mZ.append(geometry: forceGeometry.mZjLabel, update: update)
    }
}
