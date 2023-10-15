//
//  AS4Model.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Foundation

struct AS4Model: Identifiable {
    var id = UUID()
    var points: [AS4Point] = []
}


extension AS4Model: Codable {
    enum CodingKeys: String, CodingKey {
        case id, points
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.points = try container.decode([AS4Point].self, forKey: .points)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(points, forKey: .points)
    }
}
