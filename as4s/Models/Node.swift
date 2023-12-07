//
//  Node.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import Analic
import Surge

protocol Nodable: AnalyzableNode, Identifiable {
    
    associatedtype Geometry: MVCGeometry
    associatedtype Config: AS4ElementConfig
    
    var geometry: Geometry { get set }
    
    var idLabel: MVCLabelGeometry { get set }
    
    var isSelected: Bool { get set }
}

final class Node: Nodable {
    
    typealias Geometry = MVCPointGeometry
    typealias Config = AS4Config.node
    
    static var dofNum: Int = 6
    
    var id: Int
    var geometryId: Int
    
    var position: double3
    var rotation: double3 = .zero
    var condition: ALCCondition
    
    var geometry: Mevic.MVCPointGeometry
    var idLabel: MVCLabelGeometry
    
    var isSelected: Bool = false
    
    init(id: Int, position: double3, condition: ALCCondition = .free) {
        self.id = id
        self.position = position
        self.condition = condition
        
        self.geometry = MVCPointGeometry(position: float3(position), color: .init(Config.color))
        self.idLabel = MVCLabelGeometry(target: float3(position), text: String(id),
                                        forgroundColor: .init(Config.labelColor),
                                        backgroundColor: .init(AS4Config.system.backGroundColor),
                                        margin: .init(0, 8), alignment: .bottom)
        
        self.geometryId = Int(self.geometry.id)
    }
}

extension Node: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case position
//        case condition
    }
    
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(Int.self, forKey: .id)
        let position = try values.decode(double3.self, forKey: .position)
//        let condition = try values.decode(Condition.self, forKey: .condition)
        
        self.init(id: id, position: position)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(position, forKey: .position)
//        try container.encode(condition, forKey: .condition)
    }
}
