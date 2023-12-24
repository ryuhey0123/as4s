//
//  LabeledLength.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI

struct LabeledScaler: View {
    var label: String
    var value: Float
    var unit: String = "mm"
    var scale: Int = 2
    
    var body: some View {
        HStack(alignment: .bottom) {
            LabeledContent(content: {
                Text(String(format: "%.\(scale)f", value))
            }, label: {
                Text(label)
            })
            Text(unit)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

struct LabeledString: View {
    var label: String
    var value: String
    var unit: String = ""
    
    var body: some View {
        HStack(alignment: .bottom) {
            LabeledContent(content: {
                Text(value)
            }, label: {
                Text(label)
            })
            Text(unit)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

struct LabeledVector: View {
    var value: float3
    var unit: String = "mm"
    var scale: Int = 2
    
    var body: some View {
        VStack(spacing: 1.0) {
            LabeledVectorScaler(label: "X", value: value.x, unit: unit, scale: scale)
            LabeledVectorScaler(label: "Y", value: value.y, unit: unit, scale: scale)
            LabeledVectorScaler(label: "Z", value: value.z, unit: unit, scale: scale)
        }
    }
}

fileprivate struct LabeledVectorScaler: View {
    var label: String
    var value: Float
    var unit: String = "mm"
    var scale: Int = 2
    
    var body: some View {
        HStack(alignment: .bottom) {
            LabeledContent(content: {
                Text(String(format: "%.\(scale)f", value))
            }, label: {
                Text(label)
            })
            Text(unit)
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    VStack(spacing: 10.0) {
        LabeledScaler(label: "X", value: 1000.2938, unit: "mm")
            .border(.secondary)
        LabeledScaler(label: "X", value: 1.203, unit: "rad")
            .border(.secondary)
        LabeledVector(value: .init(x: 10000, y: 100000, z: 10000.00))
            .border(.secondary)
    }
    .padding()
    .frame(width: 300)
}