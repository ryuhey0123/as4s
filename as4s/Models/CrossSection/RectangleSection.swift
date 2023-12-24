//
//  RectangleSection.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import simd

final class RectangleSection: CrossSection {
    
    var width: Float
    var height: Float
    
    override var A: Float {
        width * height
    }
    
    override var Iz: Float {
        pow(width, 3) * height / 12
    }
    
    override var Iy: Float {
        pow(height, 3) * width / 12
    }
    
    override var J: Float {
        pow(height, 3) * width * (1/3 - 0.21 * height / width * (1 - pow(height / width, 4) / 12))
    }
    
    override var alphaY: Float? {
        1.5
    }
    
    override var alphaZ: Float? {
        1.5
    }
    
    init(id: Int, label: String = "", width: Float, height: Float, type: SectionType = .elastic) {
        self.width = width
        self.height = height
        
        super.init(id: id, type: type)
        
        self.label = label != "" ? label : "Rect Section \(id)"
    }
}
