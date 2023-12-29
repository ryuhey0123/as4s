//
//  DispBeam.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/29.
//

import Mevic

final class DispBeam {
    
    weak var iNode: DispNode!
    weak var jNode: DispNode!
    
    var geometry: BeamDispGeometry
    
    init(iNode: DispNode, jNode: DispNode) {
        self.iNode = iNode
        self.jNode = jNode
        self.geometry = BeamDispGeometry(i: iNode.geometry.model.position,
                                         j: jNode.geometry.model.position)
    }
}
