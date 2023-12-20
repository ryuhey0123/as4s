//
//  RFLine.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/20.
//

import SwiftUI
import simd
import Mevic

class RFLine: MVCLineGeometry {
    
    weak var iNode: Node!
    weak var jNode: Node!
    
    var chordAngle: Float
    
    var vector: float3 {
        (jNode.position - iNode.position).metal
    }
    
    var chordVector: float3 {
        vector.chordVector(angle: chordAngle).metal
    }
    
    var chordCrossVector: float3 {
        cross(chordVector, vector).normalized.metal
    }
    
    override var i: float3 {
        get { iNode.position.metal }
        set { fatalError() }
    }
    
    override var j: float3 {
        get { jNode.position.metal }
        set { fatalError() }
    }
    
    init(i: Node, j: Node, color: Color, selectable: Bool, chordAngle: Float = 0.0) {
        self.iNode = i
        self.jNode = j
        self.chordAngle = chordAngle
        
        super.init(i: i.position, j: j.position,
                   iColor: float4(color), jColor: float4(color), selectable: selectable)
    }
}
