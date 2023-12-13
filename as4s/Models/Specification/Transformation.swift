//
//  Transformation.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/13.
//

import OpenSeesCoder

final class Transformation: OSLinerTransformation {
    
    var transfTag: Int
    var vecxzX: Float
    var vecxzY: Float
    var vecxzZ: Float
    var dXi: Float?
    var dYi: Float?
    var dZi: Float?
    var dXj: Float?
    var dYj: Float?
    var dZj: Float?
    
    init(transfTag: Int, vecxzX: Float, vecxzY: Float, vecxzZ: Float, dXi: Float? = nil, dYi: Float? = nil, dZi: Float? = nil, dXj: Float? = nil, dYj: Float? = nil, dZj: Float? = nil) {
        self.transfTag = transfTag
        self.vecxzX = vecxzX
        self.vecxzY = vecxzY
        self.vecxzZ = vecxzZ
        self.dXi = dXi
        self.dYi = dYi
        self.dZi = dZi
        self.dXj = dXj
        self.dYj = dYj
        self.dZj = dZj
    }
}
