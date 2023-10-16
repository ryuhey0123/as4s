//
//  Actions.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Mevic

enum Actions {
    static func addPoint(store: Store) {
        let position: double3 = .random(in: -1...1)
        addPoint(at: position, store: store)
    }
    
    static func addPoint(at position: double3, store: Store) {
        let geom = MVCPointGeometry(position: float3(position), color: .init(x: 1, y: 0, z: 0))
        let node = MVCNode(geometry: geom)
        store.scene.rootNode.addChildNode(node)
        
        let label = MOSLabelNode("Test", target: float3(position))
        label.fontName = "Arial"
        store.overlayScene.addChild(label)
        
        store.model.points.append(AS4Point(at: position))
    }
}
