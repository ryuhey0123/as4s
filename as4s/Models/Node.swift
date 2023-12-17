//
//  Node.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Mevic
import OpenSeesCoder

final class Node: Selectable {
    
    var id: Int
    var position: float3
    var disp: float3 = .zero
    var geometry: NodeGeometry
    
    var isSelected: Bool = false {
        didSet { geometry.color = isSelected ? Config.node.selectedColor : Config.node.color }
    }
    
    init(id: Int, position: float3) {
        self.id = id
        self.position = position
        
        self.geometry = NodeGeometry(id: id, position: position.metal)
    }
}

extension Node: Renderable {
    
    func appendTo(model: Model) {
        model.nodes.append(self)
    }
    
    func appendTo(scene: GraphicScene) {
        scene.modelLayer.node.append(geometry: geometry.model)
        scene.modelLayer.nodeLabel.append(geometry: geometry.label)
        scene.dispModelLayer.node.append(geometry: geometry.disp)
        scene.dispModelLayer.node.append(geometry: geometry.dispLabel)
    }
}

extension Node: OSNode {
    
    var nodeTag: Int { id }
    
    var coords: [Float] { position.array }
    
    var massValues: [Float]? { nil }
}
