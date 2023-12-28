//
//  Node.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Mevic
import OpenSeesCoder

final class Node: Identifiable, Selectable {
    
    var id: Int
    
    var position: float3 {
        didSet { updateHandlers.forEach { $0() } }
    }
    
    var disp: float3 = .zero
    
    var geometry: NodeGeometry
    
    var isSelected: Bool = false {
        didSet { geometry.color = isSelected ? Config.node.selectedColor : Config.node.color }
    }
    
    lazy var updateHandlers: [() -> ()] = [
        { self.geometry.update(id: self.id, position: self.position) }
    ]
    
    init(id: Int, position: float3) {
        self.id = id
        self.position = position
        self.geometry = NodeGeometry(id: id, position: position)
    }
}

extension Node: Renderable {
    
    func appendTo(model: Model) {
        model.nodes.insert(self)
    }
    
    func appendTo(scene: GraphicScene) {
        scene.modelLayer.node.append(geometry: geometry.model, update: false)
        scene.modelLayer.nodeLabel.append(geometry: geometry.label, update: false)
        scene.dispModelLayer.node.append(geometry: geometry.disp, update: false)
        scene.dispModelLayer.node.append(geometry: geometry.dispLabel, update: false)
    }
}

extension Node: OSNode {
    
    var nodeTag: Int { id }
    
    var coords: [Float] { position.array }
    
    var massValues: [Float]? { nil }
}

extension Node: Equatable {
    static func == (lhs: Node, rhs: Node) -> Bool {
        lhs.id == rhs.id
    }
}
