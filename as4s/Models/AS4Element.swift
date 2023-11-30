//
//  AS4Element.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import SwiftUI
import Mevic

class AS4Element<Geometry: MVCGeometry, Config: AS4ElementConfig>: Identifiable {
    
    var id: Int
    var geometryId: UInt32
    
    var geometry: Geometry
    
    var color: Color = Config.color
    
    var idLabel: MVCLabelGeometry
    
    var isSelected: Bool = false {
        didSet { color = isSelected ? Config.selectedColor : Config.color }
    }
    
    init(id: Int, geometryId: UInt32, geometry: Geometry, idLabel: MVCLabelGeometry) {
        self.id = id
        self.geometryId = geometryId
        self.geometry = geometry
        self.idLabel = idLabel
    }
}
