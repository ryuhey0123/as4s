//
//  Mass.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/13.
//

import OpenSeesCoder

final class Mass: OSMass {
    var nodeTag: Int
    var massValues: [Float]
    
    init(nodeTag: Int, massValues: [Float]) {
        self.nodeTag = nodeTag
        self.massValues = massValues
    }
}
