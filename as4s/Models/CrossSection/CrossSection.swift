//
//  Section.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/13.
//

import OpenSeesCoder

class CrossSection: Identifiable {
    
    var id: Int
    var label: String = ""
    
    var type: SectionType
    
    /// cross-sectional area of section
    var A: Float { 0.0 }
    /// second moment of area about the local z-axis
    var Iz: Float { 0.0 }
    /// second moment of area about the local y-axis (required for 3D analysis)
    var Iy: Float { 0.0 }
    /// torsional moment of inertia of section (required for 3D analysis)
    var J: Float { 0.0 }
    /// shear shape factor along the local y-axis (optional)
    var alphaY: Float? { nil }
    /// shear shape factor along the local z-axis (optional)
    var alphaZ: Float? { nil }
    
    init(id: Int, type: SectionType) {
        self.id = id
        self.type = type
    }
}

enum SectionType: String {
    case elastic = "Elastic"
}
