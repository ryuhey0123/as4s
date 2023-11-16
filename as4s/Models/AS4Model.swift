//
//  AS4Model.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Foundation
import Mevic

struct AS4Model: Identifiable {

    // Codable
    var id = UUID()
    var nodes: [AS4Node] = []

    mutating func append(_ node: AS4Node, layer: MVCLayer, overlayLayer: MVCOverlayLayer) {
        nodes.append(node)
        layer.append(geometry: node.geometry)
        
        let label = MVCLabelNode(String(node.id), target: node.geometry)
        label.fontName = "Arial"
        overlayLayer.addChild(label)
    }
}

extension AS4Model: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case nodes
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.nodes = try container.decode([AS4Node].self, forKey: .nodes)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(nodes, forKey: .nodes)
    }
}
