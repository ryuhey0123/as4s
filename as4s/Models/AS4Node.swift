//
//  AS4Node.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import AppKit
import Foundation
import Mevic

final class AS4Node: AS4Element<MVCPointGeometry, AS4Config.node> {
    
    typealias Config = AS4Config.node
    typealias Geometry = MVCPointGeometry
    
    var position: double3
    var condition: Condition
    
    init(id: Int, position: double3, condition: Condition = .free) {
        self.position = position
        self.condition = condition
        
        let geometry = MVCPointGeometry(position: float3(position), color: .init(Config.color))
        
        let idLabel = MVCLabelGeometry(target: float3(position), text: String(id), margin: .init(0, 25), alignment: .bottom)
        
        super.init(id: id, geometry: geometry, idLabel: idLabel)
    }
}

extension AS4Node: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case position
        case condition
    }
    
    convenience init(from decoder: Decoder) throws {
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
