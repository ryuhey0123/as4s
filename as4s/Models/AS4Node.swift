//
//  AS4Node.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Foundation
import Mevic

struct AS4Node: Identifiable {

    // Codable
    var id: Int
    var position: double3
    var condition: Condition
    
    // Uncodable
    var geometry: MVCGeometry
    var idLabel: MVCLabelNode
    
    init(id: Int, position: double3, condition: Condition = .free) {
        self.id = id
        self.position = position
        self.condition = condition
        
        self.geometry = MVCPointGeometry(id: id, position: float3(position), color: .init(x: 1, y: 0, z: 0))
        self.idLabel = MVCLabelNode(String(id), target: float3(position))
    }
}

extension AS4Node: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case position
        case condition
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        let id = try values.decode(Int.self, forKey: .id)
        let position = try values.decode(double3.self, forKey: .position)
        let condition = try values.decode(Condition.self, forKey: .condition)
        
        self.init(id: id, position: position, condition: condition)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(position, forKey: .position)
        try container.encode(condition, forKey: .condition)
    }
}
