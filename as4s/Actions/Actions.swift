//
//  Actions.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import SpriteKit
import Mevic

enum Actions {
    
    // MARK: - Geometry Controll
    
    static func addNode(at position: double3, store: Store) {
        let id = store.model.nodes.count + 1
        let node = AS4Node(id: id, position: position)
        store.model.append(node, layer: store.modelLayer!, overlayLayer: store.nodeLabel!)

        Logger.action.trace("Add Point - \(node.position.debugDescription)")
    }


    // MARK: - Other Geometry

    static func addCoordinate(store: Store) {
        store.captionLayer?.append(geometry: MVCLineGeometry.x)
        store.captionLayer?.append(geometry: MVCLineGeometry.y)
        store.captionLayer?.append(geometry: MVCLineGeometry.z)

        Logger.action.trace("Add Coordinate")
    }
}
