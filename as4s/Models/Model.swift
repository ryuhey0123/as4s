//
//  Model.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Foundation
import Mevic
import OpenSeesCoder

final class Model: OSModel {
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
    
    func append(_ rendable: some Renderable, layer: MVCLayer, labelLayer: MVCLayer) {
        rendable.geometrySetup(model: self)
        rendable.append(model: self)
        layer.append(geometry: rendable.geometry)
        labelLayer.append(geometry: rendable.labelGeometry)
    }
    
    func append(_ support: Support) {
        fixes.append(support)
    }
}
