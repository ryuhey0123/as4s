//
//  floatN+Extensions.swift
//  Mevic
//
//  Created by Ryuhei Fujita on 2023/01/26.
//

import simd
import Foundation
import SwiftUI

// MARK: - Typealias

public typealias float2 = SIMD2<Float>
public typealias float3 = SIMD3<Float>
public typealias float4 = SIMD4<Float>

public typealias double2 = SIMD2<Double>
public typealias double3 = SIMD3<Double>


// MARK: - float3 Extensions

extension float3 {
    
    static var x = float3(x: 1, y: 0, z: 0)
    
    static var y = float3(x: 0, y: 1, z: 0)
    
    static var z = float3(x: 0, y: 0, z: 1)
    
    var array: [Float] {
        get { [x, y, z] }
        set { x = newValue[0]; y = newValue[1]; z = newValue[2] }
    }
    
    var xy: float2 {
        get { float2(x, y) }
        set { x = newValue.x; y = newValue.y}
    }
    
    init(_ color: Color) {
        self.init(x: Float(color.rgba.red), y: Float(color.rgba.green), z: Float(color.rgba.blue))
    }
    
    var metal: float3 {
        .init(x, z, y)
    }
}


// MARK: - float4 Extensions

extension float4 {
    var xyz: float3 {
        get { float3(x, y, z) }
        set { x = newValue.x; y = newValue.y; z = newValue.z }
    }
    
    var xy: float2 {
        get { float2(x, y) }
        set { x = newValue.x; y = newValue.y}
    }
}


// MARK: - double3 Extensions

extension double3 {
    public var description: String {
        "(\(String(format: "%.3f", x)), \(String(format: "%.3f", y)), \(String(format: "%.3f", z)))"
    }
}
