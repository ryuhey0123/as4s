//
//  Config.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/16.
//

import SwiftUI

enum Config {
    
    enum node: AS4ElementConfig {
        static var color: Color = .white
        static var selectedColor: Color = .orange
        
        static var labelFont: String = "Helvetica"
        static var labelSize: CGFloat = 10
        static var labelColor: Color = .white
        static var labelPadding: CGFloat = 10
    }
    
    enum beam: AS4ElementConfig {
        static var color: Color = .cyan
        static var selectedColor: Color = .orange
        
        static var labelFont: String = "Helvetica"
        static var labelSize: CGFloat = 10
        static var labelColor: Color = .cyan
        static var labelPadding: CGFloat = 10
    }
    
    enum support: AS4ElementConfig {
        static var color: Color = .cyan
        static var selectedColor: Color = .orange
        
        static var labelFont: String = "Helvetica"
        static var labelSize: CGFloat = 10
        static var labelColor: Color = .cyan
        static var labelPadding: CGFloat = 10
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
    
    enum drawingGide {
        static let lineColor: Color = .yellow
    }
    
    enum system {
        static let backGroundColor: Color = .init(red: 0.25, green: 0.25, blue: 0.25)
    }
}

protocol AS4ElementConfig {
    static var color: Color { get set }
    static var selectedColor: Color { get set }
    
    static var labelFont: String { get set }
    static var labelSize: CGFloat { get set }
    static var labelColor: Color { get set }
    static var labelPadding: CGFloat { get set }
}
