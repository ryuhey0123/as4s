//
//  Material.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

final class Material: Identifiable {
    
    var id: Int
    var label: String
    var E: Float
    var G: Float
    
    init(id: Int, label: String = "", E: Float, G: Float) {
        self.id = id
        self.E = E
        self.G = G
        
        if label != "" {
            self.label = label
        } else {
            self.label = "Material \(id)"
        }
    }
}
