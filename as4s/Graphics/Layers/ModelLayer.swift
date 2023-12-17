//
//  ModelLayer.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

class ModelLayer: MVCLayer, ObservableObject {
    
    let node = MVCLayer("Model-Node")
    let beam = MVCLayer("Model-Beam")
    
    let nodeLabel = MVCLayer("Model-NodeLabel")
    let beamLabel = MVCLayer("Model-BeamLabel")
    
    @Published var nodeVisiable: Bool = true {
        didSet { node.isHidden = !nodeVisiable }
    }
    
    @Published var beamVisiable: Bool = true {
        didSet { beam.isHidden = !beamVisiable }
    }
    
    @Published var nodeLabelVisiable: Bool = true {
        didSet { nodeLabel.isHidden = !nodeLabelVisiable }
    }
    
    @Published var beamLabelVisiable: Bool = true {
        didSet { beamLabel.isHidden = !beamLabelVisiable }
    }
    
    init() {
        super.init("Model")
        append(layer: node)
        append(layer: beam)
        append(layer: nodeLabel)
        append(layer: beamLabel)
    }
}
