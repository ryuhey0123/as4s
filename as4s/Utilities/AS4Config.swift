//
//  AS4Config.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/16.
//

import SwiftUI

enum AS4Config {
    
    enum node: AS4ElementConfig {
        static var color: Color = .white
        static var selectedColor: Color = .orange
        
        static let labelFont: String = "Helvetica"
        static let labelSize: CGFloat = 10
        static let labelColor: Color = .white
        static let labelPadding: CGFloat = 10
    }
    
    enum cursor {
        static let size: CGFloat = 30
        static let lineWidth: CGFloat = 1.5
        static let snapRadius: CGFloat = 50.0
    }
    
    enum selectionBox {
        static let fillColor: Color = .init(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.3)
        static let strokeColor: Color = .init(red: 0.5, green: 0.5, blue: 0.5, opacity: 0.8)
    }
    
    enum cameraControllSensitivity {
        static let rotate: Float = 1.0
        static let pan: Float = 1.0
        static let zoom: Float = 1.0
    }
}

protocol AS4ElementConfig {
    static var color: Color { get set }
    static var selectedColor: Color { get set }
}
