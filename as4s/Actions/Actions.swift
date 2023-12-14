//
//  Actions.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

enum Actions {
    
    // MARK: - Geometry Controll
    
    static func addNode(id: Int, position: float3, store: Store) {
        let node = Node(id: id, position: position)
        store.model.append(node, layer: store.modelLayer, labelLayer: store.nodeLabelLayer)
        
        Logger.action.trace("\(#function): Add Point at \(node.position.description)")
    }
    
    static func appendNode(position: float3, store: Store) {
        let id = store.model.nodes.count + 1
        let node = Node(id: id, position: position)
        store.model.append(node, layer: store.modelLayer, labelLayer: store.nodeLabelLayer)
        
        Logger.action.trace("\(#function): Add Point at \(node.position.description)")
    }
    
    static func addBeam(id: Int, i: Node, j: Node, store: Store) {
        let beam = BeamColumn(id: id, i: i, j: j)
        store.model.append(beam, layer: store.modelLayer, labelLayer: store.nodeLabelLayer)

        Logger.action.trace("\(#function): Add Beam from \(beam.iNode) to \(beam.jNode)")
    }
    
    static func addBeam(id: Int, i: Int, j: Int, store: Store) {
        let beam = BeamColumn(eleTag: id, iNode: i, jNode: j)
        store.model.append(beam, layer: store.modelLayer, labelLayer: store.nodeLabelLayer)
        
        Logger.action.trace("\(#function): Add Beam from \(beam.iNode) to \(beam.jNode)")
    }
    
//    static func addPointLoad(at id: Int, value: [Float], store: Store) {
//        let load = PointLoad(nodeId: id, value: value)
//        store.model.append(load)
//        
//        Logger.action.trace("\(#function): Add Point load at \(id)")
//    }
    
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
        
        let nodes: [(id: Int, position: float3)] = nodeData.map {
            guard let id = Int($0[0]) else { return nil }
            guard let x = Float($0[1]) else { return nil }
            guard let y = Float($0[3]) else { return nil }
            guard let z = Float($0[2]) else { return nil }
            return (id: id, position: float3(x, y, z))
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
            guard let i: Node = store.model.nodes.first(where: { $0.nodeTag == beam.iNode }) else { break }
            guard let j: Node = store.model.nodes.first(where: { $0.nodeTag == beam.jNode }) else { break }
            Actions.addBeam(id: beam.id, i: i, j: j, store: store)
        }
    }
    
    static func exexuteOpenSees(data: Data, store: Store) {
        let path = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("command.tcl")
        do {
            try data.write(to: path)
        } catch {
            fatalError("Cannot write command file at: \(path.path())")
        }
        
        let process = Process()
        process.environment = store.tclEnvironment
        process.executableURL = store.openSeesURL
        process.arguments = [path.path()]
        
        do {
            try process.run()
            process.waitUntilExit()
            
            if process.terminationStatus == 0 {
                print("Success")
            } else {
                fatalError("Error: \(process.terminationStatus)")
            }
        } catch {
            fatalError("Error occurred during OpenSees execution: \(error)")
        }
    }
    
    static func printResultData() {
        let resultURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("node_disp.out")
        let resultData = try! Data(contentsOf: resultURL)
        print(String(data: resultData, encoding: .utf8)!)
    }
}
