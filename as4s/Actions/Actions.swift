//
//  Actions.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import MGTCoder
import OpenSeesCoder

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
              let section = store.model.sections.first(where: { $0.id == section }) else {
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
        let section = RectangleSection(id: id, label: label, width: width, height: height)
        store.append(section)
        
        Logger.action.trace("\(#function): Add Section \(id)")
    }
    
    static func appendRectangleSection(label: String, width: Float, height: Float, store: Store) {
        let id = store.model.sections.count + 1
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
        
        store.selectedBeams.formUnion(selectedBeam)
        store.selectedNodes.formUnion(selectedNodes)
    }
    
    static func snap(store: Store) {
        guard let snapId = store.scene.renderer.getSnappedId() else { return }
        guard let selectedNodes = store.model.nodes.first(where: { $0.geometry.model.id == snapId }) else { return }
        store.snapNodes[0] = store.snapNodes[1]
        store.snapNodes[1] = selectedNodes
    }

    static func unselectAll(store: Store) {
        store.selectedNodes = []
        store.selectedBeams = []
        store.model.nodes.forEach { $0.isSelected = false }
        store.model.beams.forEach { $0.isSelected = false }
    }
    
    
    // MARK: Geometry Transforom
    
    static func moveSelectedObject(to value: float3, store: Store) {
        store.selectedNodes.forEach {
            $0.position += value
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
        
        store.model.beams.first(where: { $0.id == 5 })?.releaseI.y = true
        store.model.beams.first(where: { $0.id == 10 })?.releaseJ.z = true
        
        store.openSeesInput = SampleText.input
        store.openSeesStdErr = SampleText.output
        
        store.scene.updateBuffer()
    }
    
    static func importTestModel(store: Store) {
        let startTime = CACurrentMediaTime()
        
        guard let fileURL = Bundle.main.url(forResource: "TestModel-2", withExtension: "txt") else {
            fatalError("Not found TestModel.txt")
        }
        
        let mgtModel = try! MGTCoder().encode(url: fileURL, encoding: .utf8)
        
        Actions.addMaterial(id: 1, label: "SS400", E: 2.05e5, G: 1.02e3, store: store)
        Actions.addRectangleSection(id: 1, label: "100x100", width: 100, height: 100, store: store)
        
        for node in mgtModel.nodes {
            Actions.addNode(id: node.id, position: node.position, store: store)
        }
        
        for beam in mgtModel.beams {
            Actions.addBeam(id: beam.id, i: beam.iN1, j: beam.iN2, angle: beam.angle, section: 1, material: 1, store: store)
        }
        
        for support in mgtModel.constraints {
            Actions.addSupport(nodeId: support.nodeId, constrValues: support.value, store: store)
        }
        
        for nodalLoad in mgtModel.nodalLoads {
            Actions.addNodalLoad(nodeId: nodalLoad.nodeId, force: nodalLoad.force, store: store)
        }
        
        store.scene.updateBuffer()
        
        Logger.action.info("\(#function) time: \(CACurrentMediaTime() - startTime) sec")
    }
    
    
    // MARK: - OpenSees Execute
    
    enum AnalyzeError: Error {
        case terminateProcess(status: Int32)
        case invalidData(_ description: String)
    }
    
    static func analayze(store: Store, encoding: Bool = true) {
        do {
            let startTime = CACurrentMediaTime()
            
            store.progressState = .analysing
            store.progress = 0.0
            store.warningMessages = []
            store.errorMessages = []
            
            if encoding {
                store.progressTitle = "Encoding OpenSees Command File..."
                try encodeOpenSeesCommand(store: store)
                store.progress = 10.0
            }
            
            store.progressTitle = "Executing OpenSees..."
            let (stdout, stderr) = try store.openSeesDecoder.exexute(command: store.openSeesInput)
            store.openSeesStdOut = stdout
            store.openSeesStdErr = stderr
            store.progress = 20.0
            
            store.progressTitle = "Parse OpenSees Results..."
            
            let nodeResultURL = URL(fileURLWithPath: NSTemporaryDirectory())
                .appendingPathComponent("node.out")
            let eleResultURL = URL(fileURLWithPath: NSTemporaryDirectory())
                .appendingPathComponent("ele.out")
            
            let result = store.openSeesDecoder.parse(nodeReultURL: nodeResultURL, eleResultURL: eleResultURL)
            
            store.progress = 60.0
            
            store.progressTitle = "Update Results..."
            
            if let model = store.results.first(where: { $0.label == "First"}) {
                updateNodeResult(nodes: result.node, model: model, store: store)
                updateEleResult(beams: result.elasticBeam3d, model: model, store: store)
            } else {
                let model = Result(label: "First")
                updateNodeResult(nodes: result.node, model: model, store: store)
                updateEleResult(beams: result.elasticBeam3d, model: model, store: store)
                store.append(model)
            }
            
            store.progress = 80.0
            
            store.progressTitle = "Finished running \(String(format: "%.3f", CACurrentMediaTime() - startTime))sec"
            
            if !result.warning.isEmpty {
                store.progressState = .warning
                store.warningMessages.append(contentsOf: result.warning)
            } else {
                store.progressState = .success
            }
            
            store.progress = 100.0
            
            store.scene.updateBuffer()
            
        } catch EncodingError.invalidValue {
            store.progressState = .error
            store.progressTitle = "Encoding Error"
            return
            
        } catch AnalyzeError.terminateProcess(status: let error) {
            store.progressState = .error
            store.progressTitle = "Extute terminated Status: \(error)"
            
        } catch AnalyzeError.invalidData(let error) {
            store.progressState = .error
            store.progressTitle = "Invalid Data: \(error)"
            
        } catch let error {
            fatalError(error.localizedDescription)
        }
        
        store.progress = 0.0
    }
    
    private static func encodeOpenSeesCommand(store: Store) throws {
        let encoded = try OSEncoder().encode(store.model)
        store.openSeesInput = encoded
    }
    
    private static func updateNodeResult(nodes: [OSResult.Node], model: Result, store: Store) {
        for result in nodes {
            guard let node = store.model.nodes.first(where: { $0.nodeTag == result.tag }) else { break }
            
            let disp = DispNode(node: node, disp: float3(result.disps[0..<3]))
            model.disp.nodes.append(disp)
        }
    }
    
    private static func updateEleResult(beams: [OSResult.ElasticBeam3d], model: Result, store: Store) {
        for beam in store.model.beams {
            guard let iNode = model.disp.nodes.first(where: { $0.node.id == beam.iNode }),
                  let jNode = model.disp.nodes.first(where: { $0.node.id == beam.jNode }) else { break }
            
            let disp = DispBeamColumn(iNode: iNode, jNode: jNode)
            model.disp.beams.append(disp)
            
            let force = ForceBeamColumn(beam: beam)
            guard let value = beams.first(where: { $0.tag == beam.eleTag }) else { break }
            force.updateForce(force: value.iForce + value.jForce)
            model.forces.columnBeams.append(force)
        }
    }
}
