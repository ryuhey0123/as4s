//
//  Config.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/16.
//

import SwiftUI

enum Config {
    static let cursor_size: CGFloat = 30
    static let cursor_line_width: CGFloat = 1.5
    
    static let snap_radius: Float = 50.0
    
    enum node {
        static let color: Color = .white
        static let selectedColor: Color = .orange
        
        static let labelFont: String = "Helvetica"
        static let labelSize: CGFloat = 10
        static let labelColor: Color = .white
        static let labelPadding: CGFloat = 10
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
