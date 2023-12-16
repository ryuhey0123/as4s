//
//  Load.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import SwiftUI
import Mevic
import OpenSeesCoder

class NodalLoad: Renderable {
    
    // MARK: General Value
    
    var id: Int
    var node: Node
    var loadvalues: [Float]
    
    
    // MARK: Renderable Value
    
    typealias GeometryType = MVCArrowGeometry
    typealias ElementConfigType = Config.nodalLoad
    
    var geometry: Mevic.MVCArrowGeometry!
    var labelGeometry: MVCLabelGeometry!
    
    var color: Color = ElementConfigType.color
    
    init(id: Int, node: Node, loadvalues: [Float]) {
        self.id = id
        self.node = node
        self.loadvalues = loadvalues
        
        self.geometry = MVCArrowGeometry(i: node.position.metal - float3(loadvalues[0..<3]).metal * 0.01,
                                         j: node.position.metal,
                                         color: float3(color),
                                         thickness: 0.01)
        
        self.labelGeometry = Self.buildLabelGeometry(target: node.position.metal,
                                                     tag: id.description)
    }
    
    func append(model: Model) {
        model.nodalLoads.append(self)
    }
}

extension NodalLoad: OSNodalLoad {
    var nodeTag: Int { node.id }
}
