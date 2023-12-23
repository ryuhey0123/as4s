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
            Text("Beam Colmun Element")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            List {
                Section {
                    VStack {
                        LabeledContent { Text("\(beam.id)") } label: { Text("Self") }
                            .listRowSeparator(.hidden, edges: .bottom)
                        LabeledContent { Text("\(beam.i.id)") } label: { Text("Node i") }
                            .listRowSeparator(.hidden, edges: .bottom)
                        LabeledContent { Text("\(beam.j.id)") } label: { Text("Node j") }
                            .listRowSeparator(.hidden, edges: .bottom)
                    }
                } header: {
                    Text("ID")
                }
                
                Section {
                    LabeledScaler(label: "Coordinate Angle", value: beam.chordAngle, unit: "rad", scale: 3)
                        .listRowSeparator(.hidden, edges: .bottom)
                    LabeledScaler(label: "Length", value: beam.j.position.x)
                        .listRowSeparator(.hidden, edges: .bottom)
                } header: {
                    Text("Spec")
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

//#Preview {
//    BeamInspector(beam: BeamColumn(id: 1,
//                                   i: Node(id: 1, position: .init(   0, 1000,  500)),
//                                   j: Node(id: 2, position: .init(1000, 2000, 1000))))
//    .frame(width: 300, height: 600)
//}
