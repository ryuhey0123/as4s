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
        addNode(id: id, position: position, store: store)
    }
    
    static func addBeam(id: Int, i: Int, j: Int, angle: Float, section: Int, material: Int, store: Store) {
        guard let iNode = store.model.nodes.first(where: { $0.nodeTag == i }),
              let jNode = store.model.nodes.first(where: { $0.nodeTag == j }),
              let material = store.model.materials.first(where: { $0.id == material }),
              let section =  store.model.reactangle.first(where: { $0.id == section }) else {
            fatalError("Cannot find nodes \(i), \(j)")
        }
        
        let beam = BeamColumn(id: id, i: iNode, j: jNode, material: material, section: section, chordAngle: angle)
        store.append(beam)
        
        Logger.action.trace("\(#function): Add Beam from \(beam.iNode) to \(beam.jNode)")
    }
    
    static func appendBeam(i: Int, j: Int, angle: Float, section: Int, material: Int, store: Store) {
        let id = store.model.beams.count + 1
       addBeam(id: id, i: i, j: j, angle: angle, section: section, material: material, store: store)
    }
    
    static func addMaterial(id: Int, label: String, E: Float, G: Float, store: Store) {
        let material = Material(id: id, label: label, E: E, G: G)
        store.append(material)
        
        Logger.action.trace("\(#function): Add Material \(id)")
    }
    
    static func appendMaterial(label: String, E: Float, G: Float, store: Store) {
        let id = store.model.materials.count + 1
        addMaterial(id: id, label: label, E: E, G: G, store: store)
    }
    
    static func addRectangleSection(id: Int, label: String, width: Float, height: Float, store: Store) {
        let section = ReactangleSec(id: id, label: label, width: width, height: height)
        store.append(section)
        
        Logger.action.trace("\(#function): Add Section \(id)")
    }
    
    static func appendRectangleSection(label: String, width: Float, height: Float, store: Store) {
        let id = store.model.reactangle.count + 1
        addRectangleSection(id: id, label: label, width: width, height: height, store: store)
    }
    
    static func addNodalLoad(nodeId: Int, force: [Float], store: Store) {
        guard let node = store.model.nodes.first(where: { $0.nodeTag == nodeId }) else {
            fatalError("Cannot find nodes \(nodeId)")
        }
        let force = NodalLoad(id: nodeId, node: node, loadvalues: force)
        store.append(force)
        
        Logger.action.trace("\(#function): Add Nodal Load to \(node.nodeTag)")
    }
    
    static func addSupport(nodeId: Int, constrValues: [Int], store: Store) {
        guard let node = store.model.nodes.first(where: { $0.nodeTag == nodeId }) else {
            fatalError("Cannot find nodes \(nodeId)")
        }
        let support = Support(id: nodeId, node: node, constrValues: constrValues)
        store.append(support)
        
        Logger.action.trace("\(#function): Add Support to \(node.nodeTag)")
    }
    
    
    // MARK: - Other Geometry
    
    static func addCoordinate(store: Store) {
        let coord = MVCCoordGeometry(target: .zero, xDir: .x, yDir: .y, zDir: .z, scale: 100)
        store.scene.captionLayer.globalCoord.append(geometry: coord)
        
        store.scene.overlayLayer.append(geometry: MVCCursor())
        store.scene.overlayLayer.append(geometry: MVCSelectionBox())
        
        Logger.action.trace("\(#function): Add Coordinate")
    }
    
    
    // MARK: - Selection
    
    static func select(store: Store) {
        let selectedIds = store.scene.renderer.getSeletedId()
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
        
        store.selectedNodes.append(contentsOf: selectedNodes)
    }
    
    static func snap(store: Store) {
        guard let snapId = store.scene.renderer.getSnappedId() else { return }
        guard let selectedNodes = store.model.nodes.first(where: { $0.geometry.model.id == snapId }) else { return }
        store.snapNodes[0] = store.snapNodes[1]
        store.snapNodes[1] = selectedNodes
    }

    static func unselectAll(store: Store) {
        store.selectedObjects = []
        store.selectedNodes = []
        store.model.nodes.forEach { $0.isSelected = false }
        store.model.beams.forEach { $0.isSelected = false }
    }
    
    
    // MARK: Geometry Transforom
    
    static func moveSelectedObject(to value: float3, store: Store) {
        let objects = store.selectedObjects
        guard !objects.isEmpty else { return }
        
        for object in objects {
            if let object = object as? Node {
                object.position += value
            }
        }
    }
    
    
    // MARK: - Import
    
    static func buildDebugModel(store: Store) {
        Actions.addNode(id: 1, position: .init(x: -500, y: -500, z:    0), store: store)
        Actions.addNode(id: 2, position: .init(x:  500, y: -500, z:    0), store: store)
        Actions.addNode(id: 3, position: .init(x: -500, y:  500, z:    0), store: store)
        Actions.addNode(id: 4, position: .init(x:  500, y:  500, z:    0), store: store)
        Actions.addNode(id: 5, position: .init(x: -500, y: -500, z: 1000), store: store)
        Actions.addNode(id: 6, position: .init(x:  500, y: -500, z: 1000), store: store)
        Actions.addNode(id: 7, position: .init(x: -500, y:  500, z: 1000), store: store)
        Actions.addNode(id: 8, position: .init(x:  500, y:  500, z: 1000), store: store)
        
        Actions.addMaterial(id: 1, label: "SS400", E: 2.05e5, G: 1.02e3, store: store)
        Actions.addMaterial(id: 2, label: "SS490", E: 2.05e5, G: 1.02e3, store: store)
        Actions.addRectangleSection(id: 1, label: "100x100", width: 100, height: 100, store: store)
        
        Actions.addBeam(id:  1, i: 1, j: 2, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id:  2, i: 2, j: 4, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id:  3, i: 3, j: 4, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id:  4, i: 1, j: 3, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id:  5, i: 5, j: 6, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id:  6, i: 6, j: 8, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id:  7, i: 7, j: 8, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id:  8, i: 5, j: 7, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id:  9, i: 1, j: 5, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id: 10, i: 2, j: 6, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id: 11, i: 4, j: 8, angle: 0.0, section: 1, material: 1, store: store)
        Actions.addBeam(id: 12, i: 3, j: 7, angle: 0.0, section: 1, material: 1, store: store)
        
        Actions.addSupport(nodeId: 1, constrValues: [1, 1, 1, 1, 1, 1], store: store)
        Actions.addSupport(nodeId: 2, constrValues: [1, 1, 1, 0, 0, 0], store: store)
        Actions.addSupport(nodeId: 3, constrValues: [1, 1, 1, 0, 0, 0], store: store)
        Actions.addSupport(nodeId: 4, constrValues: [1, 1, 1, 0, 0, 0], store: store)
        
        Actions.addNodalLoad(nodeId: 5, force: [10e3, 0, 0, 0, 0, 0], store: store)
        Actions.addNodalLoad(nodeId: 6, force: [0, 10e3, 0, 0, 0, 0], store: store)
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
        
        Actions.addMaterial(id: 1, label: "SS400", E: 2.05e5, G: 1.02e3, store: store)
        Actions.addRectangleSection(id: 1, label: "100x100", width: 100, height: 100, store: store)
        
        for node in nodes {
            Actions.addNode(id: node.id, position: node.position, store: store)
        }
        
        for beam in beams {
            Actions.addBeam(id: beam.id, i: beam.iNode, j: beam.jNode, angle: 0.0, section: 1, material: 1, store: store)
        }
    }
    
    
    // MARK: - OpenSees Execute
    
    enum AnalyzeError: Error {
        case terminateProcess(status: Int32)
        case invalidData(_ description: String)
    }
    
    static func analayze(store: Store) {
        do {
            let startTime = CACurrentMediaTime()
            
            store.progressTitle = .analysing
            store.progress = 0.0
            
            store.progressSubtitle = "Encoding OpenSees Command File..."
            let path = try buildOpenSeesCommand(store: store)
            store.progress = 10.0
            
            store.progressSubtitle = "Executing OpenSees..."
            let (stdout, stderr) = try store.openSeesDecoder.exexute(commandFilePath: path)
            store.openSeesStdOut = stdout
            store.openSeesStdErr = stderr
            store.progress = 20.0
            
            store.progressSubtitle = "Parse OpenSees Results..."
            let result = store.openSeesDecoder.parse(data: stderr)
            store.progress = 60.0
            
            store.progressSubtitle = "Update Results..."
            updateNodeResult(nodes: result.node, store: store)
            updateEleResult(beams: result.elasticBeam3d, store: store)
            store.progress = 80.0
            
            if !result.warning.isEmpty {
                store.progressTitle = .warning
                store.progressSubtitle = result.warning[0]
            } else {
                store.progressSubtitle = "Finished running \(String(format: "%.3f", CACurrentMediaTime() - startTime))sec"
                store.progressTitle = .success
            }
            
            store.progress = 100.0
            
        } catch EncodingError.invalidValue {
            store.progressTitle = .error
            store.progressSubtitle = "Encoding Error"
            return
            
        } catch AnalyzeError.terminateProcess(status: let error) {
            store.progressTitle = .error
            store.progressSubtitle = "Extute terminated Status: \(error)"
            
        } catch AnalyzeError.invalidData(let error) {
            store.progressTitle = .error
            store.progressSubtitle = "Invalid Data: \(error)"
            
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
        store.progress = 0.0
    }
    
    private static func buildOpenSeesCommand(store: Store) throws -> URL {
        let data = try OSEncoder().encode(store.model)
        let path = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("command.tcl")
        try data.write(to: path)
        store.openSeesInput = String(data: data, encoding: .utf8) ?? ""
        return path
    }
    
    private static func updateNodeResult(nodes: [OSReslutDecoder.OSResult.Node], store: Store) {
        for result in nodes {
            if let node = store.model.nodes.first(where: { $0.nodeTag == result.tag }) {
                let value = result.disps[0..<3]
                node.geometry.disp.position = (node.position + float3(value)).metal
                node.geometry.dispLabel.target = (node.position + float3(value)).metal
                node.geometry.dispLabel.text = "(\(String(format: "%.1f", value[0])), \(String(format: "%.1f", value[1])), \(String(format: "%.1f", value[2])))"
            }
        }
    }
    
    private static func updateEleResult(beams: [OSReslutDecoder.OSResult.ElasticBeam3d], store: Store) {
        for beam in store.model.beams {
            beam.geometry.disp.i = beam.i.geometry.disp.position
            beam.geometry.disp.j = beam.j.geometry.disp.position
            
            if let result = beams.first(where: { $0.tag == beam.eleTag }) {
                let force = result.iForce + result.jForce
                beam.geometry.updateGeometry(force: force)
            }
        }
    }
}
