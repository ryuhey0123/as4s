//
//  Config.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/16.
//

import SwiftUI

enum Config {
    
    static let point_hit_test_radius: Float = 8.0
    static let line_hit_test_radius: Float = 5.0
    
    static let cursor_size: CGFloat = 30
    static let cursor_line_width: CGFloat = 1.5
    
    static let snap_radius: Float = 50.0
    
    static let point_label_fontname: String = "Helvetica"
    static let line_label_fontname: String = "Helvetica"
    
    enum color {
        static let background = NSColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        
        static let beam = Color(NSColor.cyan)
        static let truss = Color(NSColor.red)
        static let plate = Color(NSColor.blue)
        
        static let point_label = Color.white
        static let beam_label = Color.gray
        
        static let cursor = NSColor.white
        
        enum node {
            static let nomal: Color = .white
            static let selected: Color = .orange
        }
        
        enum selectionBox {
            static let fill = NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.3)
            static let stroke = NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.8)
        }
    }
    
    enum cameraControllSensitivity {
        static let rotate: Float = 1.0
        static let pan: Float = 1.0
        static let zoom: Float = 1.0
    }
}
