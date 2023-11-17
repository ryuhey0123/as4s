//
//  AS4Node.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import AppKit
import Foundation
import Mevic

final class AS4Node: Identifiable {
    
    typealias Config = AS4Config.node
    typealias Geometry = MVCPointGeometry

    // Codable
    var id: Int
    var position: double3
    var condition: Condition
    
    // Uncodable
    var geometry: Geometry
    var idLabel: MVCLabelNode
    
    // Alias
    var screenPoint: CGPoint {
        get { geometry.screenPoint }
    }
    
    var isSelected: Bool = false {
        didSet { geometry.color = .init(isSelected ? Config.selectedColor : Config.color) }
    }
    
    init(id: Int, position: double3, condition: Condition = .free) {
        self.id = id
        self.position = position
        self.condition = condition
        
        geometry = MVCPointGeometry(id: id, position: float3(position), color: .init(Config.color))
        
        idLabel = MVCLabelNode(String(id), target: geometry)
        idLabel.fontName = Config.labelFont
        idLabel.fontSize = Config.labelSize
        idLabel.fontColor = NSColor(Config.labelColor)
        idLabel.padding = Config.labelPadding
    }
    
    func isContain(in selectionBox: CGRect) -> Bool {
        let pp = geometry.screenPoint
        return (pp.x > selectionBox.minX) && (pp.y > selectionBox.minY) && (pp.x < selectionBox.maxX) && (pp.y < selectionBox.maxY)
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
