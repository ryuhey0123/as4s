//
//  NodeResult.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/14.
//

import SwiftUI
import Mevic

class NodeResult: PostProcess {
    
    var nodeTag: Int
    
    var coords: [Float]
    var disp: [Float]
    
    var geometryTag: UInt32!
    var geometry: MVCPointGeometry!
    var labelGeometry: MVCLabelGeometry!
    
    var position: float3 {
        get { .init(coords) }
        set { coords = newValue.array }
    }
    
    init(nodeTag: Int, coords: [Float], disp: [Float], geometryTag: UInt32!, geometry: MVCPointGeometry!, labelGeometry: MVCLabelGeometry!) {
        self.nodeTag = nodeTag
        self.coords = coords
        self.disp = disp
        self.geometryTag = geometryTag
        self.geometry = geometry
        self.labelGeometry = labelGeometry
    }
}
