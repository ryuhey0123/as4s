//
//  Element.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import SwiftUI
import Mevic

protocol Elementable: Identifiable {
    
    associatedtype Geometry: MVCGeometry
    associatedtype ElementConfig: AS4ElementConfig
    
    var geometryId: Int { get }
    
    var geometry: Geometry { get set }
    
    var labelGeometry: MVCLabelGeometry { get set }
    
    var color: Color { get set }
        
    var isSelected: Bool { get set }
}
