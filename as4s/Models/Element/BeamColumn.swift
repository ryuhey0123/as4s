//
//  Beam.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import Mevic
import OpenSeesCoder
import simd

final class BeamColumn: Selectable {
    
    var id: Int
    var i: Node
    var j: Node
    var chordAngle: Float
    
    var geometry: BeamGeometry!
    
    var vector: float3 {
        j.position - i.position
    }
    
    var chordVector: float3 {
        vector.chordVector(angle: chordAngle)
    }
    
    var chordCrossVector: float3 {
        cross(chordVector, vector).normalized
    }
    
    var isSelected: Bool = false {
        didSet { geometry.color = isSelected ? Config.beam.selectedColor : Config.beam.color }
    }
    
    init(id: Int, i: Node, j: Node, chordAngle: Float = 0.0) {
        self.id = id
        self.i = i
        self.j = j
        self.chordAngle = chordAngle
        self.geometry = BeamGeometry(id: id,
                                     i: i.position.metal,
                                     j: j.position.metal,
                                     zdir: chordVector.metal,
                                     ydir: chordCrossVector.metal)
    }
}

extension BeamColumn: Renderable {
    
    func appendTo(model: Model) {
        model.beams.append(self)
        model.linerTransfs.append(transformation)
    }
    
    func appendTo(scene: GraphicScene) {
        scene.modelLayer.beam.append(geometry: geometry.model)
        scene.modelLayer.beamLabel.append(geometry: geometry.label)
        scene.dispModelLayer.beam.append(geometry: geometry.disp)
        scene.forceLayer.append(forceGeometry: geometry)
    }
}

extension BeamColumn: OSElasticBeamColumn {
    
    var eleTag: Int { id }
    
    var secTag: Int { 1 }
    
    var iNode: Int { i.id }
    
    var jNode: Int { j.id }
    
    var transfTag: Int { id }
    
    var massDens: Float? { nil }
    
    var transformation: Transformation {
        Transformation(id: id, vector: chordVector)
    }
}
