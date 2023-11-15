//
//  Condition.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/12.
//

import Foundation

struct Condition {
    
    static let free: Condition = .init([Double].init(repeating: 0, count: 6))
    static let fix: Condition = .init([Double].init(repeating: .infinity, count: 6))
    
    var dx: Double
    var dy: Double
    var dz: Double
    var rx: Double
    var ry: Double
    var rz: Double
    
    init(dx: Double = 0, dy: Double = 0, dz: Double = 0, rx: Double = 0, ry: Double = 0, rz: Double = 0) {
        self.dx = dx
        self.dy = dy
        self.dz = dz
        self.rx = rx
        self.ry = ry
        self.rz = rz
    }
    
    init(_ list: [Double]) {
        self.dx = list[0]
        self.dy = list[1]
        self.dz = list[2]
        self.rx = list[3]
        self.ry = list[4]
        self.rz = list[5]
    }
}

extension Condition: Codable {
    enum CodingKeys: String, CodingKey {
        case dx, dy, dz, rx, ry, rz
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.dx = try values.decode(Double.self, forKey: .dx)
        self.dy = try values.decode(Double.self, forKey: .dy)
        self.dz = try values.decode(Double.self, forKey: .dz)
        self.rx = try values.decode(Double.self, forKey: .rx)
        self.ry = try values.decode(Double.self, forKey: .ry)
        self.rz = try values.decode(Double.self, forKey: .rz)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(dx, forKey: .dx)
        try container.encode(dy, forKey: .dy)
        try container.encode(dz, forKey: .dz)
        try container.encode(rx, forKey: .rx)
        try container.encode(ry, forKey: .ry)
        try container.encode(rz, forKey: .rz)
    }
}
