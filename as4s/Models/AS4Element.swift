//
//  AS4Element.swift
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
    
    var geometry: Geometry { get set }
    
    var idLabel: MVCLabelGeometry { get set }
        
    var isSelected: Bool { get set }
}

extension Elementable {
    
    var color: Color {
        get {
            isSelected ? Config.selectedColor : Config.color
        }
    }
}

