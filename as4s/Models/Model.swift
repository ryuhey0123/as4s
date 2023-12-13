//
//  Model.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Foundation
import Mevic
import OpenSeesCoder

struct Model: OSModel {
    var ndm: Int
    var ndf: Int?
    
    var nodes: [Node] = []
    
    var elasticSec: [Section] = []
    var linerTransfs: [Transformation] = []
    
    var beams: [Beam] = []
    var trusses: [Truss] = []
    
    var fixes: [Support] = []
    var masses: [Mass] = []
    
    var timeSeries: some OSTimeSeries = OSConstantTimeSeries(tag: 0)
    
    var plainPatterns: [OSPlainPattern] = []
    
    var nodeRecorder: OSNodeRecorder = OSNodeRecorder(fileName: "res_node_disp", fileOption: .file, dofs: [1, 2, 3, 4, 5, 6], respType: .disp)
    
    var system: OSSystem = .BandSPD
    var numberer: OSNumberer = .RCM
    var constraints: OSConstraints = .Plain
    var integrator: some OSIntegrator = OSLoadControl(lambda: 1.0)
    var algorithm: some OSAlgorithm = OSLinear()
    var analysis: OSAnalysis = OSAnalysis(analysisType: .Static)
    var analyze: OSAnalyze = OSAnalyze(numIncr: 1)
    
    init() {
        self.ndm = 3
        self.ndf = nil
    }
    
    init(ndm: Int, ndf: Int? = nil) {
        self.ndm = ndm
        self.ndf = ndf
    }

    mutating func append(_ node: Node, layer: MVCLayer, labelLayer: MVCLayer) {
        nodes.append(node)
        layer.append(geometry: node.geometry)
        labelLayer.append(geometry: node.labelGeometry)
    }
    
    mutating func append(_ beam: Beam, layer: MVCLayer, labelLayer: MVCLayer) {
        beam.geometrySetup(model: self)
        beams.append(beam)
        layer.append(geometry: beam.geometry)
        labelLayer.append(geometry: beam.labelGeometry)
    }
    
    mutating func append(_ support: Support) {
        fixes.append(support)
    }
    
//    mutating func append(_ load: NodalLoad) {
//        pointLoads.append(load)
//    }
    
    mutating func updateNodes(layer: MVCLayer, labelLayer: MVCLayer) {
        for node in nodes {
            layer.append(geometry: node.geometry)
            labelLayer.append(geometry: node.labelGeometry)
        }
    }
    
    mutating func updateBeams(layer: MVCLayer, labelLayer: MVCLayer) {
        for beam in beams {
            layer.append(geometry: beam.geometry)
            labelLayer.append(geometry: beam.labelGeometry)
        }
    }
}
//
//extension Model: Codable {
//
//    enum CodingKeys: String, CodingKey {
//        case id
//    }
//    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(UUID.self, forKey: .id)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//    }
//}
