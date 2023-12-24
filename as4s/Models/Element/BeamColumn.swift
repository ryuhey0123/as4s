//
//  Beam.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import simd
import Mevic
import OpenSeesCoder

final class BeamColumn: Identifiable, Selectable {
    
    var id: Int
    
    var i: Node
    
    var j: Node
    
    var material: Material
    
    var section: CrossSection
    
    var coordAngle: Float
    
    var geometry: BeamGeometry!
    
    var secTag: Int = 0
    
    var length: Float {
        simd.length(vector)
    }
    
    var vector: float3 {
        j.position - i.position
    }
    
    var coordVector: float3 {
        vector.chordVector(angle: coordAngle)
    }
    
    var coordCrossVector: float3 {
        cross(coordVector, vector).normalized
    }
    
    var isSelected: Bool = false {
        didSet { geometry.color = isSelected ? Config.beam.selectedColor : Config.beam.color }
    }
    
    init(id: Int, i: Node, j: Node, material: Material, section: CrossSection, chordAngle: Float = 0.0) {
        self.id = id
        self.i = i
        self.j = j
        self.material = material
        self.section = section
        self.coordAngle = chordAngle
        self.geometry = BeamGeometry(id: id,
                                     i: i.position,
                                     j: j.position,
                                     xdir: vector.normalized,
                                     zdir: coordVector,
                                     ydir: coordCrossVector)
        
        i.updateHandlers.append {
            self.geometry.updateNode(id: self.id, i: self.i.position, j: self.j.position,
                                     xdir: self.vector.normalized, zdir: self.coordVector, ydir: self.coordCrossVector)
        }
        
        j.updateHandlers.append {
            self.geometry.updateNode(id: self.id, i: self.i.position, j: self.j.position,
                                     xdir: self.vector.normalized, zdir: self.coordVector, ydir: self.coordCrossVector)
        }
    }
}

extension BeamColumn: Renderable {
    
    func appendTo(model: Model) {
        model.beams.insert(self)
        model.linerTransfs.insert(transformation)
        
        if let sec = model.elasticSec.first(where: { $0.key == (section.id, material.id) }) {
            secTag = sec.secTag
        } else {
            secTag = model.elasticSec.count + 1
            model.elasticSec.insert(ElasticSection(id: secTag, section: section, material: material))
        }
    }
    
    func appendTo(scene: GraphicScene) {
        scene.modelLayer.beam.append(geometry: geometry.model)
        scene.modelLayer.beamLabel.append(geometry: geometry.label)
        scene.dispModelLayer.beam.append(geometry: geometry.disp)
        scene.forceLayer.append(forceGeometry: geometry)
        scene.captionLayer.beamCoord.append(geometry: geometry.localCoord)
    }
}

extension BeamColumn: OSElasticBeamColumn {
    
    var eleTag: Int { id }
    
    var iNode: Int { i.id }
    
    var jNode: Int { j.id }
    
    var transfTag: Int { id }
    
    var releaseZ: Int? { nil }
    
    var releaseY: Int? { nil }
    
    var massDens: Float? { nil }
    
    var transformation: Transformation {
        Transformation(id: id, vector: -coordVector)
    }
}

extension BeamColumn: Equatable {
    static func == (lhs: BeamColumn, rhs: BeamColumn) -> Bool {
        lhs.eleTag == rhs.eleTag
    }
}
