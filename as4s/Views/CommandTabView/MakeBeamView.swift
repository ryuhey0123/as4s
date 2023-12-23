//
//  MakeBeamView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI

struct MakeBeamView: View {
    @EnvironmentObject var store: Store
    
    @State private var id: Int?
    @State private var iNode: Int?
    @State private var jNode: Int?
    @State private var angle: Float? = 0.0
    @State private var section: Int? = 1
    
    var body: some View {
        VStack {
            Text("Make Beam")
                .font(.headline)
                .padding(.bottom, 20)
            Form {
                InputIntValueField(value: $id, label: "ID", systemImage: "1.square")
                    .disabled(true)
                    .padding(.bottom, 20)
                
                Section {
                    InputIntValueField(value: $iNode, label: "i")
                    InputIntValueField(value: $jNode, label: "j")
                        .padding(.bottom, 20)
                } header: {
                    Text("Node ID")
                        .font(.subheadline)
                }
                
                Section {
                    InputIntValueField(value: $section, label: "ID")
                        .padding(.bottom, 20)
                } header: {
                    Text("Section")
                        .font(.subheadline)
                }
                
                Section {
                    InputFloatValueField(value: $angle, label: "deg")
                        .padding(.bottom, 20)
                } header: {
                    Text("Coord Angle")
                        .font(.subheadline)
                }
            }
            HStack {
                Spacer()
                Button {
                    iNode = nil
                    jNode = nil
                    angle = 0.0
                    section = 1
                } label: {
                    Text("Reset")
                }
                Button {
                    guard let iNode = iNode,
                          let jNode = jNode,
                          let angle = angle,
                          let section = section else { return }
                    Actions.appendBeam(i: iNode, j: jNode, angle: angle, section: section, store: store)
                    id = store.model.beams.count + 1
                } label: {
                    Text("OK")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .padding(.trailing)
        .onAppear {
            id = store.model.beams.count + 1
        }
        .onChange(of: store.snapNodes) {
            iNode = store.snapNodes[0]?.id
            jNode = store.snapNodes[1]?.id
        }
    }
}

#Preview {
    HStack {
        MakeBeamView()
            .environmentObject(Store())
            .frame(width: 170)
        Divider()
        MakeBeamView()
            .environmentObject(Store())
            .frame(width: 500)
    }
}
