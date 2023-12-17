//
//  ModelLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

class ModelLayer: MVCLayer {
    
    var node = MVCLayer("Model-Node")
    var beam = MVCLayer("Model-Beam")
    
    var nodeLabel = MVCLayer("Model-NodeLabel")
    var beamLabel = MVCLayer("Model-BeamLabel")
    
    init() {
        super.init("Model")
        append(layer: node)
        append(layer: beam)
        append(layer: nodeLabel)
        append(layer: beamLabel)
    }
}
