//
//  Actions.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import OpenSeesCoder
import simd

enum Actions {
    
    // MARK: - Geometry Controll
    
    static func addNode(id: Int, position: float3, store: Store) {
        let node = Node(id: id, position: position)
        store.append(node)
        
        Logger.action.trace("\(#function): Add Point at \(node.position.description)")
    }
    
    static func appendNode(position: float3, store: Store) {
        let id = store.model.nodes.count + 1
        let node = Node(id: id, position: position)
        store.append(node)
        Logger.action.trace("\(#function): Add Point at \(node.position.description)")
    }
    
    static func addBeam(id: Int, i: Node, j: Node, store: Store) {
        let beam = BeamColumn(id: id, i: i, j: j)
        store.append(beam)

        Logger.action.trace("\(#function): Add Beam from \(beam.iNode) to \(beam.jNode)")
    }
    
    static func addBeam(id: Int, i: Int, j: Int, store: Store) {
        guard let iNode = store.model.nodes.first(where: { $0.nodeTag == i }),
              let jNode = store.model.nodes.first(where: { $0.nodeTag == j }) else {
            fatalError("Cannot find nodes \(i), \(j)")
        }
        
        let beam = BeamColumn(id: id, i: iNode, j: jNode)
        store.append(beam)
        
        Logger.action.trace("\(#function): Add Beam from \(beam.iNode) to \(beam.jNode)")
    }
    
    static func addNodalLoad(id: Int, force: [Float], store: Store) {
        guard let node = store.model.nodes.first(where: { $0.nodeTag == id }) else {
            fatalError("Cannot find nodes \(id)")
        }
        let force = NodalLoad(id: id, node: node, loadvalues: force)
        store.append(force)
        
        Logger.action.trace("\(#function): Add Nodal Load to \(node.nodeTag)")
    }
    
    static func addSupport(id: Int, constrValues: [Int], store: Store) {
        guard let node = store.model.nodes.first(where: { $0.nodeTag == id }) else {
            fatalError("Cannot find nodes \(id)")
        }
        let support = Support(id: id, node: node, constrValues: constrValues)
        store.append(support)
        
        Logger.action.trace("\(#function): Add Support to \(node.nodeTag)")
    }
    
    // MARK: - Other Geometry
    
    static func addCoordinate(store: Store) {
        let x = MVCLineGeometry(j: .x.metal * 100, color: .x, selectable: false)
        let y = MVCLineGeometry(j: .y.metal * 100, color: .y, selectable: false)
        let z = MVCLineGeometry(j: .z.metal * 100, color: .z, selectable: false)
        store.scene.captionLayer.append(geometry: x)
        store.scene.captionLayer.append(geometry: y)
        store.scene.captionLayer.append(geometry: z)
        
        store.scene.overlayLayer.append(geometry: MVCCursor())
        store.scene.overlayLayer.append(geometry: MVCSelectionBox())
        
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
    
    
    // MARK: - OpenSees Execute
    
    static func buildCommand(store: Store) {
        
    }
    
    static func exexuteOpenSees(store: Store) {
        let data = try! OSEncoder().encode(store.model)
        
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
            
            print("OutputData:")
            print(String(data: outputData, encoding: .utf8) ?? "")
            
            let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
            store.openSeesStdErrData = errorData
            
            print("ErrorData:")
            print(String(data: errorData, encoding: .utf8) ?? "")
            
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
        
        var nodeDisps: [Int: [Float]] = [:]
        var eleForce: [Int: [Float]] = [:]
        
        var disps: [Float] = []
        var forces: [Float] = []
        
        let nodeRegex = /(\sNode:\s)([0-9]+)/
        let nodeDispRegex = /(\sDisps:)([\s0-9e.-]+)/
        let nodeIdRegex = /\sID\s:/
        
        let eleRegex = /ElasticBeam3d: ([0-9]+)/
        let eleForceRgex = /\sEnd ([1|2]) Forces \(P Mz Vy My Vz T\):\s([0-9.e+\-\s]+)/
        
        var currentNodeId: Int = 0
        var currentEleId: Int = 0
        
        var isNodeSection: Bool = false
        var isEleSection: Bool = false
        
        for line in resultLines {
            
            if let match = line.wholeMatch(of: nodeRegex) {
                isNodeSection = true
                currentNodeId = Int(match.2)!
                disps = []
            }
            
            if let match = line.wholeMatch(of: eleRegex) {
                isEleSection = true
                currentEleId = Int(match.1)!
                forces = []
            }
            
            if isNodeSection {
                if let match = line.wholeMatch(of: nodeDispRegex) {
                    let value = match.2.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
                    disps += value.map { Float($0)! }
                }
                if let _ = line.prefixMatch(of: nodeIdRegex) {
                    isNodeSection = false
                    nodeDisps[currentNodeId] = disps
                }
            }
            
            if isEleSection {
                if let match = line.wholeMatch(of: eleForceRgex) {
                    let value = match.2.trimmingCharacters(in: .whitespaces).components(separatedBy: " ")
                    forces += value.map { Float($0)! }
                    
                    if match.1 == "2" {
                        isEleSection = false
                        eleForce[currentEleId] = forces
                    }
                }
            }
        }
        
        for result in nodeDisps {
            if let node = store.model.nodes.first(where: { $0.nodeTag == result.key }) {
                let value = result.value[0..<3]
                node.geometry.disp.position += float3(value).metal
                node.geometry.dispLabel.text = "(\(String(format: "%.1f", value[0])), \(String(format: "%.1f", value[1])), \(String(format: "%.1f", value[2])))"
            }
        }
        
        for beam in store.model.beams {
            beam.geometry.disp.i = beam.i.geometry.disp.position
            beam.geometry.disp.j = beam.j.geometry.disp.position
            
            let force = eleForce[beam.id]!
            beam.geometry.updateGeometry(force: force)
        }
    }
}
