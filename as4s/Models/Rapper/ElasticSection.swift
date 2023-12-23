//
//  ElasticSection.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/14.
//

import OpenSeesCoder

final class ElasticSection {
    
    var id: Int
    var section: CrossSection
    var material: Material
    
    var key: (Int, Int) { (section.id, material.id) }
    
    init(id: Int, section: CrossSection, material: Material) {
        guard section.type == .elastic else { fatalError() }
        
        self.id = id
        self.section = section
        self.material = material
    }
}

extension ElasticSection: OSElasticSection {
    
    var secTag: Int { id }
    
    var E: Float { material.E }
    
    var A: Float { section.A }
    
    var Iz: Float { section.Iz}
    
    var Iy: Float { section.Iy }
    
    var G: Float { material.G }
    
    var J: Float { section.J }
    
    var alphaY: Float? { section.alphaY }
    
    var alphaZ: Float? { section.alphaZ }
}
