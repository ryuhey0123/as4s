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
    
    var vXLabel: MVCLayer = MVCLayer("Force-VxLabel") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var vYLabel: MVCLayer = MVCLayer("Force-VyLabel") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var vZLabel: MVCLayer = MVCLayer("Force-VzLabel") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var mXLabel: MVCLayer = MVCLayer("Force-MxLabel") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var mYLabel: MVCLayer = MVCLayer("Force-MyLabel") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var mZLabel: MVCLayer = MVCLayer("Force-MzLabel") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    init() {
        super.init("Model")
        append(layer: vX)
        append(layer: vY)
        append(layer: mZ)
        append(layer: mX)
        append(layer: mY)
        append(layer: vXLabel)
        append(layer: vYLabel)
        append(layer: mZLabel)
        append(layer: mXLabel)
        append(layer: mYLabel)
        
        vX.isShown = false
        vY.isShown = false
        vZ.isShown = false
        mX.isShown = false
        mY.isShown = false
        mZ.isShown = false
        vXLabel.isShown = false
        vYLabel.isShown = false
        vZLabel.isShown = false
        mXLabel.isShown = false
        mYLabel.isShown = false
        mZLabel.isShown = false
    }
}
