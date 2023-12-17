//
//  Element.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import OpenSeesCoder

final class Truss: OSTrussElement {
    
    var eleTag: Int
    
    var iNode: Int
    
    var jNode: Int
    
    var secTag: Int
    
    var rho: Float?
    
    var cFlag: Int?
    
    var rFlag: Int?
    
    init(eleTag: Int, iNode: Int, jNode: Int, secTag: Int, rho: Float? = nil, cFlag: Int? = nil, rFlag: Int? = nil) {
        self.eleTag = eleTag
        self.iNode = iNode
        self.jNode = jNode
        self.secTag = secTag
        self.rho = rho
        self.cFlag = cFlag
        self.rFlag = rFlag
    }
}
