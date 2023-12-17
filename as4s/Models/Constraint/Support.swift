//
//  Support.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import SwiftUI
import Mevic
import OpenSeesCoder

final class Support: Renderable {
    
    var id: Int
    var node: Node
    var constrValues: [Int]
    
    var geometry: MVCSupportGeometry!
    var color: Color = Config.support.color
    
    var type: MVCSupportGeometry.SupportType {
        if constrValues == [1, 1, 1, 1, 1, 1] {
            return .fix
        } else {
            return .pin
        }
    }
    
    init(id: Int, node: Node, constrValues: [Int]) {
        self.id = id
        self.node = node
        self.constrValues = constrValues
        self.geometry = MVCSupportGeometry(target: node.position.metal, type: type, color: float4(color))
    }
    
    func appendTo(model: Model) {
        model.fixes.append(self)
    }
    
    func appendTo(scene: GraphicScene) {
        scene.modelLayer.support.append(geometry: geometry)
    }
}

extension Support: OSFix {
    
    var nodeTag: Int { node.id }
}
