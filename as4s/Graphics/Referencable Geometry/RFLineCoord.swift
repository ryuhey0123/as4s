//
//  RFLineCoord.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/20.
//

import SwiftUI
import Mevic

class RFLineCoord: MVCCoordGeometry {
    
    weak var line: RFLine!
    
    override var target: float3 {
        get { line.center }
        set { fatalError() }
    }
    
    override var xDir: float3 {
        get { line.vector.normalized * 100 }
        set { fatalError() }
    }
    
    override var yDir: float3 {
        get { line.chordCrossVector * 100 }
        set { fatalError() }
    }
    
    override var zDir: float3 {
        get { line.chordVector * 100 }
        set { fatalError() }
    }
    
    init(line: RFLine) {
        self.line = line
        super.init()
    }
}
