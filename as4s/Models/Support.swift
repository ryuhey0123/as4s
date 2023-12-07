//
//  Support.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import Analic

class Support: ConstraintableNode {
    
    var nodeId: Int
    
    var constraint: ALCConstraint
    
    init(id: Int, constraint: ALCConstraint) {
        self.nodeId = id
        self.constraint = constraint
    }
}
