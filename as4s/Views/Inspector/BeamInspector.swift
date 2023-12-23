//
//  BeamInspector.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/21.
//

import SwiftUI

struct BeamInspector: View {
    var beam: BeamColumn
    
    @State private var iCoordinateExpended: Bool = false
    @State private var jCoordinateExpended: Bool = false
    @State private var vectorExpended: Bool = false
    @State private var coordVectorExpended: Bool = false
    @State private var coordCrossVectorExpended: Bool = false
    
    var body: some View {
        VStack {
            Text("Beam Colmun Element (ID: \(beam.id))")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            List {
                Section {
                    LabeledScaler(label: "Coordinate Angle", value: beam.coordAngle, unit: "rad", scale: 3)
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "Length", value: beam.j.position.x)
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Genaral")
                }
                
                Section {
                    LabeledContent { Text("\(beam.section.label)") } label: { Text("Label") }
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledContent { Text("\(beam.section.type.rawValue)") } label: { Text("Type") }
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "Area", value: beam.section.A / 100, unit: "cm2")
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "Iy", value: beam.section.Iy / 10000, unit: "cm4")
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "Iz", value: beam.section.Iz / 10000, unit: "cm4")
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "J", value: beam.section.J / 10000, unit: "cm4")
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "AlphaY", value: beam.section.alphaY ?? 0.0, unit: "")
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "AlphaZ", value: beam.section.alphaZ ?? 0.0, unit: "")
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Section (ID: \(beam.section.id))")
                }
                
                Section {
                    LabeledContent { Text("\(beam.material.label)") } label: { Text("Label") }
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "E", value: beam.material.E, unit: "N/mm2")
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "G", value: beam.material.G, unit: "N/mm2")
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Material (ID: \(beam.material.id))")
                }
                
                Section(isExpanded: $iCoordinateExpended) {
                    LabeledVector(value: beam.i.position)
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Coordinate i (ID: \(beam.i.id))")
                }
                
                Section(isExpanded: $jCoordinateExpended) {
                    LabeledVector(value: beam.j.position)
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Coordinate j (ID: \(beam.j.id))")
                }
                
                Section(isExpanded: $vectorExpended) {
                    LabeledVector(value: beam.vector.normalized, unit: "")
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Vector")
                }
                
                Section(isExpanded: $coordVectorExpended) {
                    LabeledVector(value: beam.coordVector, unit: "")
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Coordinate Axis")
                }
                
                Section(isExpanded: $coordCrossVectorExpended) {
                    LabeledVector(value: beam.coordCrossVector, unit: "")
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Cross Coordinate Axis")
                }
            }
            .listStyle(.sidebar)
            .scrollContentBackground(.hidden)
        }
        .background(.ultraThinMaterial)
    }
}

#Preview {
    BeamInspector(beam: BeamColumn(
        id: 1,
        i: Node(id: 1, position: .init(   0, 1000,  500)),
        j: Node(id: 2, position: .init(1000, 2000, 1000)),
        material: Material(id: 1, E: 2.05e5, G: 2.0e3),
        section: ReactangleSec(id: 1, width: 200, height: 200)
    ))
    .frame(width: 300, height: 600)
    .environmentObject(Store.debug)
}
