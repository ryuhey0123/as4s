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
        store.model.append(node, layer: store.modelLayer, labelLayer: store.nodeLabelLayer)
        
        Logger.action.trace("\(#function): Add Point at \(node.position.description)")
    }
    
    static func addBeam(i: double3, j: double3, store: Store) {
        let id = store.model.beams.count + 1
        let beam = AS4Beam(id: id, i: i, j: j)
        store.model.append(beam, layer: store.modelLayer, labelLayer: store.nodeLabelLayer)
        
        Logger.action.trace("\(#function): Add Beam at \(beam.i.description) to \(beam.j.description)")
    }
    
    // MARK: - Other Geometry
    
    static func addCoordinate(store: Store) {
        store.captionLayer.append(geometry: MVCLineGeometry.x)
        store.captionLayer.append(geometry: MVCLineGeometry.y)
        store.captionLayer.append(geometry: MVCLineGeometry.z)
        
        Logger.action.trace("\(#function): Add Coordinate")
    }
}
