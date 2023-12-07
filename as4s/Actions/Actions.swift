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
    
    static func addNode(id: Int, position: double3, store: Store) {
        let node = Node(id: id, position: position)
        store.model.append(node, layer: store.modelLayer, labelLayer: store.nodeLabelLayer)
        
        Logger.action.trace("\(#function): Add Point at \(node.position.description)")
    }
    
    static func addBeam(id: Int, i: Node, j: Node, store: Store) {
        let beam = Beam(id: id, i: i, j: j)
        store.model.append(beam, layer: store.modelLayer, labelLayer: store.nodeLabelLayer)

        Logger.action.trace("\(#function): Add Beam from \(beam.i.id) to \(beam.j.id)")
    }
    
    // MARK: - Other Geometry
    
    static func addCoordinate(store: Store) {
        let x = MVCLineGeometry(j: .x * 1000, color: .x, selectable: false)
        let y = MVCLineGeometry(j: .y * 1000, color: .y, selectable: false)
        let z = MVCLineGeometry(j: .z * 1000, color: .z, selectable: false)
        store.captionLayer.append(geometry: x)
        store.captionLayer.append(geometry: y)
        store.captionLayer.append(geometry: z)
        
        Logger.action.trace("\(#function): Add Coordinate")
    }
    
    
    // MARK: - Import
    
    static func importTestModel(store: Store) {
        guard let fileURL = Bundle.main.url(forResource: "TestModel", withExtension: "txt") else {
            fatalError("Not found TestModel.txt")
        }
        guard let fileContents = try? String(contentsOf: fileURL) else {
            fatalError("Cannot read file.")
        }
        
        let data = fileContents.components(separatedBy: "*")
        
        let nodeData: [[String]] = data[6].components(separatedBy: "\n").filter { !$0.isEmpty }.dropFirst(2).map {
            $0.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        }
        
        let nodes: [(id: Int, position: double3)] = nodeData.map {
            guard let id = Int($0[0]) else { return nil }
            guard let x = Double($0[1]) else { return nil }
            guard let y = Double($0[3]) else { return nil }
            guard let z = Double($0[2]) else { return nil }
            return (id: id, position: double3(x, y, z))
        }.compactMap { $0 }
        
        let beamData: [[String]] = data[7].components(separatedBy: "\n").filter { !$0.isEmpty }.dropFirst(2).map {
            $0.components(separatedBy: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
        }.filter { $0[1] == "BEAM" }
        
        let beams: [(id: Int, iNode: Int, jNode: Int)] = beamData.map {
            guard let id = Int($0[0]) else { return nil }
            guard let iNode = Int($0[4]) else { return nil }
            guard let jNode = Int($0[5]) else { return nil }
            return (id: id, iNode: iNode, jNode: jNode)
        }.compactMap { $0 }
        
        for node in nodes {
            Actions.addNode(id: node.id, position: node.position, store: store)
        }
        
        for beam in beams {
            guard let i: Node = store.model.nodes.first(where: { $0.id == beam.iNode }) else { break }
            guard let j: Node = store.model.nodes.first(where: { $0.id == beam.jNode }) else { break }
            Actions.addBeam(id: beam.id, i: i, j: j, store: store)
        }
    }
    
    static func linerStaticAnalyze(store: Store) {
        let model = store.model
        let solver = store.solver
        solver.analyze(model: model)
    }
}
