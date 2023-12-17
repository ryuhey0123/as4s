//
//  LoadLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

class LoadLayer: MVCLayer {
    
    var nodal = MVCLayer("Load-Nodal")
    var nodalLabel = MVCLayer("Load-NodalLabel")
    
    init() {
        super.init("Load")
        append(layer: nodal)
        append(layer: nodalLabel)
    }
}
