//
//  floatN+Extensions.swift
//  Mevic
//
//  Created by Ryuhei Fujita on 2023/01/26.
//

import simd
import Foundation

// MARK: - Typealias

public typealias float2 = SIMD2<Float>
public typealias float3 = SIMD3<Float>
public typealias float4 = SIMD4<Float>


// MARK: - float3 Extensions

extension float3 {
    var array: [Float] {
        get { [x, y, z] }
        set { x = newValue[0]; y = newValue[1]; z = newValue[2] }
    }
    
    var xy: float2 {
        get { float2(x, y) }
        set { x = newValue.x; y = newValue.y}
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
    
    func projectedPoint(uniforms: Uniforms) -> float4 {
        uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * self + float4(uniforms.cameraPosition, 0)
    }
    
    func screenPoint(uniforms: Uniforms, frame: NSRect) -> CGPoint {
        let projected = self.projectedPoint(uniforms: uniforms)
        let inShader = projected.xy / projected.w
        let screen = CGPoint(x: frame.width * CGFloat(inShader.x + 1) / 2, y: frame.height * CGFloat(inShader.y + 1) / 2)
        return screen
    }
}
