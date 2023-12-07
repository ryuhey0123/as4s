//
//  Element.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import SwiftUI
import Mevic
import Analic

protocol Elementable: AnalyzableElement, Identifiable {
    
    associatedtype Geometry: MVCGeometry
    associatedtype Config: AS4ElementConfig
    
    var geometryId: Int { get }
    
    var geometry: Geometry { get set }
    
    var idLabel: MVCLabelGeometry { get set }
    
    var color: Color { get set }
        
    var isSelected: Bool { get set }
}

