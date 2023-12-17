//
//  ForceLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

class ForceLayer: MVCLayer {
    
    var vX: MVCLayer = MVCLayer("Force-Vx")
    var vY: MVCLayer = MVCLayer("Force-Vy")
    var vZ: MVCLayer = MVCLayer("Force-Vz")
    var mX: MVCLayer = MVCLayer("Force-Mx")
    var mY: MVCLayer = MVCLayer("Force-My")
    var mZ: MVCLayer = MVCLayer("Force-Mz")
    
    var vXLabel: MVCLayer = MVCLayer("Force-VxLabel")
    var vYLabel: MVCLayer = MVCLayer("Force-VyLabel")
    var vZLabel: MVCLayer = MVCLayer("Force-VzLabel")
    var mXLabel: MVCLayer = MVCLayer("Force-MxLabel")
    var mYLabel: MVCLayer = MVCLayer("Force-MyLabel")
    var mZLabel: MVCLayer = MVCLayer("Force-MzLabel")
    
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
    }
}
