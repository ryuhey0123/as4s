//
//  DispModelLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/18.
//

import SwiftUI
import Mevic

class DispModelLayer: MVCLayer {
    
    var node = MVCLayer("DispModel-Node")
    var beam = MVCLayer("DispModel-Beam")
    var support = MVCLayer("DispModel-Support")
    
    var nodeLabel = MVCLayer("DispModel-NodeLabel")
    
    init() {
        super.init("DispModel")
        append(layer: node)
        append(layer: beam)
        append(layer: support)
        append(layer: nodeLabel)
    }
}

