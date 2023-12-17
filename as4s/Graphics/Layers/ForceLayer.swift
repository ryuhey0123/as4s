//
//  ForceLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

class ForceLayer: MVCLayer, ObservableObject {
    
    let vX: MVCLayer = MVCLayer("Force-Vx")
    let vY: MVCLayer = MVCLayer("Force-Vy")
    let vZ: MVCLayer = MVCLayer("Force-Vz")
    let mX: MVCLayer = MVCLayer("Force-Mx")
    let mY: MVCLayer = MVCLayer("Force-My")
    let mZ: MVCLayer = MVCLayer("Force-Mz")
    
    let vXLabel: MVCLayer = MVCLayer("Force-VxLabel")
    let vYLabel: MVCLayer = MVCLayer("Force-VyLabel")
    let vZLabel: MVCLayer = MVCLayer("Force-VzLabel")
    let mXLabel: MVCLayer = MVCLayer("Force-MxLabel")
    let mYLabel: MVCLayer = MVCLayer("Force-MyLabel")
    let mZLabel: MVCLayer = MVCLayer("Force-MzLabel")
    
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
