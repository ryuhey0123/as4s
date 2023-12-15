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
    
    // MARK: Renderable
    
    var nodes: [Node] = []
    var beams: [BeamColumn] = []
    var trusses: [Truss] = []
    var fixes: [Support] = []
    
    // MARK: Specification
    
    var elasticSec: [ElasticSection] = [.default]
    var linerTransfs: [Transformation] = []
    
    // MARK: Loads
    
    var masses: [Mass] = []
    var nodalLoads: [NodalLoad] = []
    var timeSeries: some OSTimeSeries = OSConstantTimeSeries(tag: 1)
    
    var plainPatterns: [OSPlainPattern] { [
        OSPlainPattern(patternTag: 1, tsTag: 1, loads: nodalLoads)
    ] }
    
    // MARK: Output

    var nodeRecorder: OSNodeRecorder = .init(fileName: "tmp/node_disp.out", fileOption: .file, dofs: [1, 2, 3, 4, 5, 6], respType: .disp)
    
    // MARK: Analyze
    
    var system: OSSystem = .BandSPD
    var numberer: OSNumberer = .RCM
    var constraints: OSConstraints = .Plain
    var integrator: some OSIntegrator = OSLoadControl(lambda: 1.0)
    var algorithm: some OSAlgorithm = OSLinear()
    var analysis: OSAnalysis = OSAnalysis(analysisType: .Static)
    var analyze: OSAnalyze = OSAnalyze(numIncr: 1)
    
    init(ndm: Int = 3, ndf: Int? = 6) {
        self.ndm = ndm
        self.ndf = ndf
    }
    
    func append(_ rendable: some Renderable, layer: MVCLayer, labelLayer: MVCLayer) {
        rendable.append(model: self)
        
        layer.append(geometry: rendable.geometry)
        
        if let rendable = rendable as? (any Displacementable) {
            layer.append(geometry: rendable.dispGeometry)
        }
        
        labelLayer.append(geometry: rendable.labelGeometry)
    }
}
