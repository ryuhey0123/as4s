//
//  Section.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/13.
//

import OpenSeesCoder

final class Section: OSElasticSection {
    
    var secTag: Int
    
    var E: Float
    
    var A: Float
    
    var Iz: Float
    
    var Iy: Float
    
    var G: Float
    
    var J: Float
    
    var alphaY: Float?
    
    var alphaZ: Float?
    
    init(secTag: Int, E: Float, A: Float, Iz: Float, Iy: Float, G: Float, J: Float, alphaY: Float? = nil, alphaZ: Float? = nil) {
        self.secTag = secTag
        self.E = E
        self.A = A
        self.Iz = Iz
        self.Iy = Iy
        self.G = G
        self.J = J
        self.alphaY = alphaY
        self.alphaZ = alphaZ
    }
}
