//
//  Actions.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import Yams

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
        let x = MVCLineGeometry(j: .x * 100, color: .x, selectable: false)
        let y = MVCLineGeometry(j: .y * 100, color: .y, selectable: false)
        let z = MVCLineGeometry(j: .z * 100, color: .z, selectable: false)
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
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        process.standardOutput = outputPipe
        process.standardError = errorPipe
        process.environment = store.tclEnvironment
        process.executableURL = store.openSeesBinaryURL
        process.arguments = [path.path()]
        
        do {
            try process.run()
            process.waitUntilExit()
            
            let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
            store.openSeesStdOutData = outputData
            
            let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
            store.openSeesStdErrData = errorData
            
            if process.terminationStatus == 0 {
                Logger.openSees.info("Success execute OpenSees")
            } else {
                fatalError("Error: \(process.terminationStatus)")
            }
        } catch {
            fatalError("Error occurred during OpenSees execution: \(error)")
        }
    }
    
    static func updateNodeDisp(store: Store) {
        guard let resultData = store.openSeesStdErrData,
              let resultLines = String(data: resultData, encoding: .utf8)?.components(separatedBy: .newlines)[12...] else { return }
        
        var results: [Int: [Float]] = [:]
        var currentNodeId: Int? = nil
        var disps: [Float] = []
        
        for line in resultLines {
            if line.starts(with: " Node:") {
                let regex = /(\sNode:\s)([0-9]+)/
                let match = line.wholeMatch(of: regex)
                currentNodeId = Int(match!.2)
                disps = []
                
            } else if let currentNodeId = currentNodeId {
                let regex = /(\sDisps:)([\s0-9.-]+)/
                
                if let match = line.wholeMatch(of: regex) {
                    let value = match.2.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
                    disps += value.map { Float($0)! }
                }
                
                let end = /(\sID\s:\s)([\s0-9]+)/
                if let _ = line.wholeMatch(of: end) {
                    results[currentNodeId] = disps
                }
            }
        }
        
        for result in results {
            let tag = result.key
            let value = result.value
            
            if let node = store.model.nodes.first(where: { $0.nodeTag == tag }) {
                let disp = float3(value[0], value[1], value[2])
                let geometry = MVCPointGeometry(position: node.position + disp,
                                                color: .init(1, 0, 0))
                store.modelLayer.append(geometry: geometry)
            }
        }
    }
}
