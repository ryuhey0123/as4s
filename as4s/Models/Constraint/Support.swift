//
//  Support.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import OpenSeesCoder

final class Support: OSFix {

    var nodeTag: Int
    var constrValues: [Int]
    
    init(nodeTag: Int, constrValues: [Int]) {
        self.nodeTag = nodeTag
        self.constrValues = constrValues
    }
}
