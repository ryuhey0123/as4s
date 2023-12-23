//
//  Section.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/13.
//

import OpenSeesCoder

protocol CrossSection {
    
    var id: Int { get }
    
    /// cross-sectional area of section
    var A: Float { get }
    
    /// second moment of area about the local z-axis
    var Iz: Float { get }
    
    /// second moment of area about the local y-axis (required for 3D analysis)
    var Iy: Float { get }
    
    /// torsional moment of inertia of section (required for 3D analysis)
    var J: Float { get }
    
    /// shear shape factor along the local y-axis (optional)
    var alphaY: Float? { get }
    
    /// shear shape factor along the local z-axis (optional)
    var alphaZ: Float? { get }
    
    var type: SectionType { get }
}

enum SectionType {
    case elastic
}
