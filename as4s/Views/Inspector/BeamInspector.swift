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
        VStack {
            Text("Beam Colmun Element")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            Form {
                Section {
                    VStack {
                        LabeledContent { Text("\(beam.id)") } label: { Text("Self") }
                            .listRowSeparator(.hidden, edges: .bottom)
                        LabeledContent { Text("\(beam.i.id)") } label: { Text("i") }
                            .listRowSeparator(.hidden, edges: .bottom)
                        LabeledContent { Text("\(beam.j.id)") } label: { Text("j") }
                            .listRowSeparator(.hidden, edges: .bottom)
                    }
                } header: {
                    Text("ID")
                }
                
                Section {
                    LabeledVector(value: beam.i.position)
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Coordinate i (ID: \(beam.i.id))")
                }
                
                Section {
                    LabeledVector(value: beam.j.position)
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Coordinate j (ID: \(beam.j.id))")
                }
                
                Section {
                    LabeledScaler(label: "Coord Angle", value: beam.chordAngle, unit: "rad", scale: 3)
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "Length", value: beam.j.position.x)
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Spec")
                }
                
                Section {
                    LabeledVector(value: beam.vector.normalized, unit: "")
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Vector")
                }
                
                Section {
                    LabeledVector(value: beam.chordVector, unit: "")
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Coord Vector")
                }
                
                Section {
                    LabeledVector(value: beam.chordCrossVector, unit: "")
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Coord Cross Vector")
                }
            }
            .scrollContentBackground(.hidden)
        }
        .background(.ultraThinMaterial)
    }
}

#Preview {
    BeamInspector(beam: BeamColumn(id: 1,
                                   i: Node(id: 1, position: .init(   0, 1000,  500)),
                                   j: Node(id: 2, position: .init(1000, 2000, 1000))))
    .frame(width: 300, height: 600)
}
