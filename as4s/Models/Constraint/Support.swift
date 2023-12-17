//
//  Support.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import SwiftUI
import Mevic
import OpenSeesCoder

final class Support: OSFix, Renderable {
    
    typealias GeometryType = MVCPointGeometry
    typealias ElementConfigType = Config.support
    
    var nodeTag: Int
    var constrValues: [Int]
    
    var geometryTag: UInt32!
    var geometry: Mevic.MVCPointGeometry!
    var labelGeometry: Mevic.MVCLabelGeometry!
    
    var color: Color = .white
    
    init(nodeTag: Int, constrValues: [Int]) {
        self.nodeTag = nodeTag
        self.constrValues = constrValues
    }
    
    func geometrySetup(model: Model) {}
    
    func append(model: Model) {
        model.fixes.append(self)
    }
    
    func append(scene: GraphicScene) {}
}
