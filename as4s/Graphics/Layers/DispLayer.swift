//
//  DispLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/30.
//

import Mevic

class DispLayer: MVCLayer {
    
    var node = MVCLayer("Disp-Node")
    var beam = MVCLayer("Disp-Beam")
    var value = MVCLayer("Disp-Value")
    
    override init(_ label: String? = nil) {
        super.init(label)
        append(layer: node)
        append(layer: beam)
        append(layer: value)
    }
}
