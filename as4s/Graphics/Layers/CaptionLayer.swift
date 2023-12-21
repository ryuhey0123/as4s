//
//  CaptionLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

class CaptionLayer: MVCLayer {
    
    var globalCoord = MVCLayer("Caption-GlobalCoord")
    var beamCoord = MVCLayer("Caption-BeamCoord")
    
    init() {
        super.init("Caption")
        append(layer: globalCoord)
        append(layer: beamCoord)
        
        beamCoord.isShown = false
    }
}
