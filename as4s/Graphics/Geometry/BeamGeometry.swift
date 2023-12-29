//
//  BeamGeometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI
import Mevic

struct BeamGeometry: Geometry {
    
    typealias ElementConfigType = Config.beam
    
    var color: Color = ElementConfigType.color {
        didSet {
            model.iColor = float4(float3(color), 1)
            model.jColor = float4(float3(color), 1)
        }
    }
    
    var model: MVCLineGeometry
    var label: MVCLabelGeometry
    var localCoord: MVCCoordGeometry
    
    init(id: Int, i: float3, j: float3, xdir: float3, zdir: float3, ydir: float3) {
        let i = i.metal
        let j = j.metal
        let xdir = xdir.metal
        let zdir = zdir.metal
        let ydir = ydir.metal
        
        model = MVCLineGeometry(i: i, j: j, iColor: float4(color), jColor: float4(color))
        label = Self.defaultLabel(target: (i + j) / 2, tag: id.description)
        
        localCoord = MVCCoordGeometry(target: (i + j) / 2, xDir: xdir, yDir: ydir, zDir: zdir, scale: 100)
    }
    
    mutating func updateNode(id: Int, i: float3, j: float3, xdir: float3, zdir: float3, ydir: float3) {
        let i = i.metal
        let j = j.metal
        let xdir = xdir.metal
        let zdir = zdir.metal
        let ydir = ydir.metal
        
        label.target = (i + j) / 2
        localCoord.target = (i + j) / 2
        localCoord.xDir = xdir
        localCoord.yDir = ydir
        localCoord.zDir = zdir
        
        if model.i != i {
            updateNode(i: i)
        }
        
        if model.j != j {
            updateNode(j: j)
        }
    }
    
    private mutating func updateNode(i: float3) {
        model.i = i
    }
    
    private mutating func updateNode(j: float3) {
        model.j = j
    }
}
