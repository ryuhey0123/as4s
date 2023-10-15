//
//  AS4Point.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import Foundation

struct AS4Point: Identifiable {
    var id = UUID()
    var position: double3 = .zero  // mm
    var deformation: double3 = .zero // mm
    
    init(id: UUID, position: double3, deformation: double3) {
        self.id = id
        self.position = position
        self.deformation = deformation
    }
    
    init(at position: double3) {
        self.position = position
    }
}

extension AS4Point: Codable {
    enum CodingKeys: String, CodingKey {
        case id, position, deformation
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(UUID.self, forKey: .id)
        let position = try values.decode(double3.self, forKey: .position)
        let deformation = try values.decode(double3.self, forKey: .deformation)
        self.init(id: id, position: position, deformation: deformation)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(position, forKey: .position)
        try container.encode(deformation, forKey: .deformation)
    }
}
