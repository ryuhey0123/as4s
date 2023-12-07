//
//  Load.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import Mevic
import Analic

protocol Loadable: AnalyzableLoad {}

class PointLoad: AnalyzablePointLoad, Loadable {
    
    var nodeId: Int
    var load: ALCLoad
    
    init(nodeId: Int, value: [Double]) {
        self.nodeId = nodeId
        self.load = ALCLoad(type: .point, value: value)
    }
}
