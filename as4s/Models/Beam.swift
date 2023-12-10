//
//  Beam.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import SwiftUI
import Mevic
import Analic
import Surge

final class Beam: Elementable {
    
    typealias Geometry = MVCLineGeometry
    typealias Config = AS4Config.beam
    
    var id: Int
    var geometryId: Int
    
    var i: Node
    var j: Node
    
    var coordAngle: Double = 0.0
    
    var geometry: Geometry
    var labelGeometry: MVCLabelGeometry
    
    var material: AnalyzableMaterial = ALCSteel.sn400b
    var section: AnalyzableSection = ALCSection.default
    
    var color: Color = Config.color {
        didSet {
            geometry.iColor = float4(float3(color), 1)
            geometry.jColor = float4(float3(color), 1)
        }
    }
    
    var isSelected: Bool = false {
        didSet { color = isSelected ? Config.selectedColor : Config.color }
    }
    
    var forceMatrix: Surge.Matrix<Double>?
    
    init(id: Int, i: Node, j: Node) {
        self.id = id
        self.i = i
        self.j = j
        self.geometry = MVCLineGeometry(i: float3(i.position), j: float3(j.position), color: float3(Config.color))
        self.labelGeometry = MVCLabelGeometry(target: float3((i.position + j.position) / 2), text: String(id),
                                        forgroundColor: .init(Config.labelColor), backgroundColor: .init(AS4Config.system.backGroundColor))
        
        self.geometryId = Int(self.geometry.id)
    }
}

extension Beam: AnalyzableBeam {
    var nodeI: Int {
        <#code#>
    }
    
    var nodeJ: Int {
        <#code#>
    }
    
    var positions: Analic.LinePoints<Double> {
        <#code#>
    }
    
    var positionI: double3 {
        i.position
    }
    
    var positionJ: double3 {
        j.position
    }
    
    var analyzableNodeI: Int {
        i.id
    }
    
    var analyzableNodeJ: Int {
        j.id
    }
}

//extension Beam: Codable {
//    
//    enum CodingKeys: String, CodingKey {
//        case id
//        case i
//        case j
//    }
//    
//    convenience init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        let id = try values.decode(Int.self, forKey: .id)
//        let i = try values.decode(double3.self, forKey: .i)
//        let j = try values.decode(double3.self, forKey: .j)
//        
//        self.init(id: id, i: i, j: j)
//    }
//    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(i, forKey: .i)
//        try container.encode(j, forKey: .j)
//    }
//}
