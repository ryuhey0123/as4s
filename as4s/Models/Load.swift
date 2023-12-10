//
//  Load.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import Mevic

protocol Loadable {}

class PointLoad: Loadable {
    
    var nodeId: Int
    
    init(nodeId: Int, value: [Double]) {
        self.nodeId = nodeId
    }
}
