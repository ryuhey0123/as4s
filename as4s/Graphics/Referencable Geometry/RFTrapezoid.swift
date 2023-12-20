//
//  RFPoint.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/20.
//

import SwiftUI
import Mevic

class RFTrapezoid: MVCTrapezoidGeometry {
    
    weak var line: RFLine!
    
    var directionType: DirectionType
    
    override var i: float3 {
        get { line.i }
        set { fatalError() }
    }
    
    override var j: float3 {
        get { line.j }
        set { fatalError() }
    }
    
    override var direction: float3 {
        get {
            switch directionType {
                case .z:
                    line.chordCrossVector
                case .y:
                    line.chordVector
            }
        }
        set { fatalError() }
    }
    
    enum DirectionType {
        case z, y
    }
    
    init(line: RFLine, iColor: Color, jColor: Color, direction: DirectionType) {
        self.line = line
        self.directionType = direction
        
        super.init()
        
        self.iColor = float4(iColor)
        self.jColor = float4(jColor)
    }
}
