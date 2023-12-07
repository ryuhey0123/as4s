//
//  Model.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Foundation
import Mevic
import Analic

struct Model: Identifiable {

    var id = UUID()
    
    var nodes: [Node] = []
    var elements: [any Elementable] = []
    var loads: [any Loadable] = []

    mutating func append(_ node: Node, layer: MVCLayer, labelLayer: MVCLayer) {
        nodes.append(node)
        layer.append(geometry: node.geometry)
        labelLayer.append(geometry: node.labelGeometry)
    }
    
    mutating func append(_ beam: Beam, layer: MVCLayer, labelLayer: MVCLayer) {
        elements.append(beam)
        layer.append(geometry: beam.geometry)
        labelLayer.append(geometry: beam.labelGeometry)
    }
    
    mutating func updateNodes(layer: MVCLayer, labelLayer: MVCLayer) {
        for node in nodes {
            layer.append(geometry: node.geometry)
            labelLayer.append(geometry: node.labelGeometry)
        }
    }
    
    mutating func updateBeams(layer: MVCLayer, labelLayer: MVCLayer) {
        for beam in elements {
            layer.append(geometry: beam.geometry)
            labelLayer.append(geometry: beam.labelGeometry)
        }
    }
}

extension Model: AnalyzableModel {
    
    var analyzableNodes: [AnalyzableNode] { nodes }
    
    var analyzableElements: [AnalyzableElement] { elements }
    
    var analyzableLoads: [AnalyzableLoad] { loads }
    
    var analyzableConstraint: [AnalyzableConstraint] { [] }
}

extension Model: Codable {

    enum CodingKeys: String, CodingKey {
        case id
//        case nodes
//        case elements
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
//        self.nodes = try container.decode([Node].self, forKey: .nodes)
//        self.elements = try container.decode([Beam].self, forKey: .elements)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
//        try container.encode(nodes, forKey: .nodes)
//        try container.encode(elements, forKey: .elements)
    }
}
