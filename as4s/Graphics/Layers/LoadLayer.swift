//
//  LoadLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

class LoadLayer: MVCLayer {
    
    var nodal = MVCLayer("Load-Nodal") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    var nodalLabel = MVCLayer("Load-NodalLabel") {
        willSet { self.isShown = newValue.isShown ? true : self.isShown }
    }
    
    init() {
        super.init("Load")
        append(layer: nodal)
        append(layer: nodalLabel)
        
        nodal.isShown = false
        nodalLabel.isShown = false
    }
}
