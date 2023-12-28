//
//  Model.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import OpenSeesCoder

final class Model: OSModel {
    
    var ndm: Int
    var ndf: Int?
    
    // MARK: Renderable
    
    var nodes: Set<Node> = []
    var beams: Set<BeamColumn> = []
    var trusses: Set<Truss> = []
    var fixes: Set<Support> = []
    
    // MARK: Specification
    
    var elasticSec: Set<ElasticSection> = []
    var linerTransfs: Set<Transformation> = []
    
    // MARK: Loads
    
    var masses: Set<Mass> = []
    var nodalLoads: [NodalLoad] = []
    var timeSeries: some OSTimeSeries = OSConstantTimeSeries(tag: 1)
    
    var plainPatterns: Set<OSPlainPattern> { [
        OSPlainPattern(patternTag: 1, tsTag: 1, loads: nodalLoads)
    ] }
    
    // MARK: Recoders
    
    var nodeRecoders: [OSNodeRecorder] = [
//        OSNodeRecorder(fileName: "tmp/res_node_disp", fileOption: .file, dofs: [1, 2, 3, 4, 5, 6], respType: .disp),
//        OSNodeRecorder(fileName: "tmp/res_node_react", fileOption: .file, dofs: [1, 2, 3, 4, 5, 6], respType: .reaction),
    ]
    
    var elementRecoders: [OSElementRecoder] = [
//        OSElementRecoder(fileName: "tmp/res_ele_force", fileOption: .file, args: ["force"])
    ]
    
    // MARK: Analyze
    
    var system: OSSystem = .BandSPD
    var numberer: OSNumberer = .RCM
    var constraints: OSConstraints = .Plain
    var integrator: some OSIntegrator = OSLoadControl(lambda: 1.0)
    var algorithm: some OSAlgorithm = OSLinear()
    var analysis: OSAnalysis = OSAnalysis(analysisType: .Static)
    var analyze: OSAnalyze = OSAnalyze(numIncr: 1)
    
    // MARK: Other
    
    var sections: [CrossSection] = []
    var materials: [Material] = []
    
    init(ndm: Int = 3, ndf: Int? = 6) {
        self.ndm = ndm
        self.ndf = ndf
    }
}
