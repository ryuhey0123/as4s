//
//  RectangleSection.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import simd

final class RectangleSection {
    
    var id: Int
    var label: String
    
    var width: Float
    var height: Float
    var type: SectionType
    
    init(id: Int, label: String = "", width: Float, height: Float, type: SectionType = .elastic) {
        self.id = id
        self.width = width
        self.height = height
        self.type = type
        
        if label != "" {
            self.label = label
        } else {
            self.label = "Rect Section \(id)"
        }
    }
}

extension RectangleSection: CrossSection {
    
    var A: Float {
        width * height
    }
    
    var Iz: Float {
        pow(width, 3) * height / 12
    }
    
    var Iy: Float {
        pow(height, 3) * width / 12
    }
    
    var J: Float {
        pow(height, 3) * width * (1/3 - 0.21 * height / width * (1 - pow(height / width, 4) / 12))
    }
    
    var alphaY: Float? {
        1.5
    }
    
    var alphaZ: Float? {
        1.5
    }
}
