//
//  Load.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import Mevic
import Analic

protocol Loadable: AnalyzableLoad {}

class PointLoad: AnalyzablePointLoad {
    var node: AnalyzableNode
    
    var qx: Double = 0.0
    var qy: Double = 0.0
    var qz: Double = 0.0
    var mx: Double = 0.0
    var my: Double = 0.0
    var mz: Double = 0.0
    
    init(node: AnalyzableNode, array: [Double]) {
        self.node = node
        self.qx = array[0]
        self.qy = array[1]
        self.qz = array[2]
        self.mx = array[3]
        self.my = array[4]
        self.mz = array[5]
    }
}
