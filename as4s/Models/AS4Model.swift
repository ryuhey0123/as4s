//
//  AS4Model.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Foundation

struct AS4Model: Identifiable {
    var id = UUID()
    
    var positions: [float3] = []
}


extension AS4Model: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case positions
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        positions = try container.decode([float3].self, forKey: .positions)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(positions, forKey: .positions)
    }
}
