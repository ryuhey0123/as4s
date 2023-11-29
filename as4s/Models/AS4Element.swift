//
//  AS4Element.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import Foundation
import Mevic

class AS4Element<Geometry: MVCGeometry, Config: AS4ElementConfig>: Identifiable {
    
    var id: Int
    
    var geometry: Geometry
    
    var idLabel: MVCLabelGeometry
    
    var isSelected: Bool = false
    
    init(id: Int, geometry: Geometry, idLabel: MVCLabelGeometry) {
        self.id = id
        self.geometry = geometry
        self.idLabel = idLabel
    }
}
