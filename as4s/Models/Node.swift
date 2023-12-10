//
//  Node.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

protocol Nodable: Identifiable {
    
    associatedtype Geometry: MVCGeometry
    associatedtype ElementConfig: AS4ElementConfig
    
    var geometry: Geometry { get set }
    
    var labelGeometry: MVCLabelGeometry { get set }
    
    var color: Color { get set }
    
    var isSelected: Bool { get set }
}

final class Node: Nodable {
    
    typealias Geometry = MVCPointGeometry
    typealias ElementConfig = Config.node
    
    static var dofNum: Int = 6
    
    var id: Int
    var geometryId: Int
    
    var position: double3
    var rotation: double3 = .zero
    
    var geometry: Geometry
    var labelGeometry: MVCLabelGeometry
    
    var color: Color = ElementConfig.color {
        didSet {
            geometry.color = float4(float3(color), 1)
        }
    }
    
    var isSelected: Bool = false {
        didSet { color = isSelected ? ElementConfig.selectedColor : ElementConfig.color }
    }
    
    init(id: Int, position: double3) {
        self.id = id
        self.position = position
        
        self.geometry = MVCPointGeometry(position: float3(position), color: .init(ElementConfig.color))
        self.labelGeometry = MVCLabelGeometry(target: float3(position), text: String(id),
                                        forgroundColor: .init(ElementConfig.labelColor),
                                        backgroundColor: .init(Config.system.backGroundColor),
                                        margin: .init(0, 8), alignment: .bottom)
        
        self.geometryId = Int(self.geometry.id)
    }
}

extension Node: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case position
    }
    
    convenience init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let id = try values.decode(Int.self, forKey: .id)
        let position = try values.decode(double3.self, forKey: .position)
        
        self.init(id: id, position: position)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(position, forKey: .position)
    }
}