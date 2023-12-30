//
//  ResultLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/29.
//

import Mevic

class ResultLayer: MVCLayer {
    
    var disp = DispLayer("Result-Disp")
    var beamForce = ForceLayer()
    
    override init(_ label: String? = nil) {
        super.init(label)
        append(layer: disp)
        append(layer: beamForce)
    }
}
