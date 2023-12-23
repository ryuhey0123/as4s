//
//  Material.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

final class Material {
    
    var id: Int
    var E: Float
    var G: Float
    
    init(id: Int, E: Float, G: Float) {
        self.id = id
        self.E = E
        self.G = G
    }
}
