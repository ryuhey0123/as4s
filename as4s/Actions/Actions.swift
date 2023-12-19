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
        
//        store.scene.overlayLayer.append(geometry: MVCCursor())
        store.scene.overlayLayer.append(geometry: MVCSelectionBox())
        
        Logger.action.trace("\(#function): Add Coordinate")
    }
    
    
    // MARK: - Selection
    
    static func select(store: Store) {
        let selectedIds = store.scene.renderer.getSeletionId()
        guard !selectedIds.isEmpty else { return }
        
        let selectedNodes = store.model.nodes.filter({
            selectedIds.contains(Int($0.geometry.model.id))
        })
        
        let selectedBeam = store.model.beams.filter({
            selectedIds.contains(Int($0.geometry.model.id))
        })
        
        selectedNodes.forEach { $0.isSelected = true }
        selectedBeam.forEach { $0.isSelected = true }
        
        store.selectedObjects.append(contentsOf: selectedNodes)
        store.selectedObjects.append(contentsOf: selectedBeam)
    }
    
    static func unselectAll(store: Store) {
        store.selectedObjects = []
        store.model.nodes.forEach { $0.isSelected = false }
        store.model.beams.forEach { $0.isSelected = false }
    }
    
    
    // MARK: - Import
    
    static func buildSmallModel(store: Store) {
        Actions.addNode(id: 1, position: .init(x: -500, y: -500, z:    0), store: store)
        Actions.addNode(id: 2, position: .init(x:  500, y: -500, z:    0), store: store)
        Actions.addNode(id: 3, position: .init(x: -500, y:  500, z:    0), store: store)
        Actions.addNode(id: 4, position: .init(x:  500, y:  500, z:    0), store: store)
        Actions.addNode(id: 5, position: .init(x: -500, y: -500, z: 1000), store: store)
        Actions.addNode(id: 6, position: .init(x:  500, y: -500, z: 1000), store: store)
        Actions.addNode(id: 7, position: .init(x: -500, y:  500, z: 1000), store: store)
        Actions.addNode(id: 8, position: .init(x:  500, y:  500, z: 1000), store: store)
        
        Actions.addBeam(id:  1, i: 1, j: 2, store: store)
        Actions.addBeam(id:  2, i: 2, j: 4, store: store)
        Actions.addBeam(id:  3, i: 3, j: 4, store: store)
        Actions.addBeam(id:  4, i: 1, j: 3, store: store)
        
        Actions.addBeam(id:  5, i: 5, j: 6, store: store)
        Actions.addBeam(id:  6, i: 6, j: 8, store: store)
        Actions.addBeam(id:  7, i: 7, j: 8, store: store)
        Actions.addBeam(id:  8, i: 5, j: 7, store: store)
        
        Actions.addBeam(id:  9, i: 1, j: 5, store: store)
        Actions.addBeam(id: 10, i: 2, j: 6, store: store)
        Actions.addBeam(id: 11, i: 4, j: 8, store: store)
        Actions.addBeam(id: 12, i: 3, j: 7, store: store)
        
        Actions.addSupport(id: 1, constrValues: [1, 1, 1, 0, 0, 0], store: store)
        Actions.addSupport(id: 2, constrValues: [1, 1, 1, 0, 0, 0], store: store)
        Actions.addSupport(id: 3, constrValues: [1, 1, 1, 0, 0, 0], store: store)
        Actions.addSupport(id: 4, constrValues: [1, 1, 1, 0, 0, 0], store: store)
        
        Actions.addNodalLoad(id: 5, force: [10e3, 0, 0, 0, 0, 0], store: store)
        Actions.addNodalLoad(id: 6, force: [0, 10e3, 0, 0, 0, 0], store: store)
    }
    
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
    
    static func analayze(store: Store) {
        exexuteOpenSees(store: store)
        
        guard let data = store.openSeesStdErrData else { return }
        let result = parseResultData(data: data)
        
        updateNodeResult(nodeDisps: result.node, store: store)
        updateEleResult(eleForce: result.ele, store: store)
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
    
    static func parseResultData(data: Data) -> (node: [Int: [Float]], ele: [Int: [Float]] ){
        guard let resultLines = String(data: data, encoding: .utf8)?.components(separatedBy: .newlines) else {
            fatalError("Cannnot read lines")
        }
        
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
        
        return (node: nodeDisps, ele: eleForce)
    }
    
    static func updateNodeResult(nodeDisps: [Int: [Float]], store: Store) {
        for result in nodeDisps {
            if let node = store.model.nodes.first(where: { $0.nodeTag == result.key }) {
                let value = result.value[0..<3]
                node.geometry.disp.position = (node.position + float3(value)).metal
                node.geometry.dispLabel.target = (node.position + float3(value)).metal
                node.geometry.dispLabel.text = "(\(String(format: "%.1f", value[0])), \(String(format: "%.1f", value[1])), \(String(format: "%.1f", value[2])))"
            }
        }
    }
    
    static func updateEleResult(eleForce: [Int: [Float]], store: Store) {
        for beam in store.model.beams {
            beam.geometry.disp.i = beam.i.geometry.disp.position
            beam.geometry.disp.j = beam.j.geometry.disp.position
            
            let force = eleForce[beam.id]!
            beam.geometry.updateGeometry(force: force)
        }
    }
}
