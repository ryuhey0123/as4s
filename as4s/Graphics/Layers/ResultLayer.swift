//
//  ResultLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/29.
//

import Mevic

class ResultLayer: MVCLayer {
    
    var nodeDisp = MVCLayer("Result-Node-Disp")
    var beamDisp = MVCLayer("Result-Beam-Disp")
    
    var dispLabel = MVCLayer("Result-Label-Node-Disp")
    
    override init(_ label: String? = nil) {
        super.init(label)
        
        append(layer: nodeDisp)
        append(layer: beamDisp)
        
        append(layer: dispLabel)
    }
}
