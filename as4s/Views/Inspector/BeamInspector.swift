//
//  BeamInspector.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/21.
//

import SwiftUI

struct BeamInspector: View {
    var beam: BeamColumn
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Beam: \(beam.id)")
                .font(.headline)
            
            GroupBox(label: Text("Coordinate i (ID: \(beam.i.id))"), content: {
                LabeledFloatValue(label: "X:", value: beam.i.position.x)
                LabeledFloatValue(label: "Y:", value: beam.i.position.y)
                LabeledFloatValue(label: "Z:", value: beam.i.position.z)
            })
            
            GroupBox(label: Text("Coordinate j (ID: \(beam.j.id))"), content: {
                LabeledFloatValue(label: "X:", value: beam.j.position.x)
                LabeledFloatValue(label: "Y:", value: beam.j.position.y)
                LabeledFloatValue(label: "Z:", value: beam.j.position.z)
            })
            
            GroupBox(label: Text("Spec"), content: {
                LabeledFloatValue(label: "Coord Angle:", value: beam.chordAngle)
                LabeledFloatValue(label: "Length:", value: beam.j.position.x)
                LabeledVectorValue(label: "Vector:", value: beam.vector)
                LabeledVectorValue(label: "Chord vector:", value: beam.chordVector)
                LabeledVectorValue(label: "Chord Cross vector:", value: beam.chordCrossVector)
            })
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    struct LabeledFloatValue: View {
        var label: String
        var value: Float
        
        var body: some View {
            LabeledContent(content: {
                Text(String(format: "%.2f", value))
                    .font(.body)
            }, label: {
                Text(label)
                    .font(.body)
            })
            .frame(width: 150, alignment: .leading)
            .padding(.leading, 10)
        }
    }
    
    struct LabeledVectorValue: View {
        var label: String
        var value: float3
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(label)
                    .font(.body)
                Text("\(String(format: "%.2f", value.x)), \(String(format: "%.2f", value.y)), \(String(format: "%.2f", value.z))")
                    .font(.callout)
            }
            .frame(width: 150, alignment: .leading)
            .padding(.leading, 10)
        }
    }
}

#Preview {
    BeamInspector(beam: BeamColumn(id: 1,
                                   i: Node(id: 1, position: .init(   0, 1000,  500)),
                                   j: Node(id: 2, position: .init(1000, 2000, 1000))))
}
