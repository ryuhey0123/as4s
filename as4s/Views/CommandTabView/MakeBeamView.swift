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
    
    @State private var selectedSectionId: Int = 1
    @State private var selectedMaterialId: Int = 1
    
    var body: some View {
        VStack {
            Text("Beam-Column")
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
                    InputFloatValueField(value: $angle, label: "deg")
                        .padding(.bottom, 20)
                } header: {
                    Text("Coord Angle")
                        .font(.subheadline)
                }
                
                Section {
                    Picker("Section", selection: $selectedSectionId) {
                        ForEach(store.model.reactangle) {
                            Text("\($0.id): \($0.label)")
                        }
                    }
                    .padding(.trailing, 8)
                }
                
                Section {
                    MaterialPicker(selection: $selectedMaterialId)
                        .padding(.trailing, 8)
                }
            }
            
            SubmitButtom(cancelAction: {
                iNode = nil
                jNode = nil
                angle = 0.0
            }, submitAction: {
                guard let iNode = iNode,
                      let jNode = jNode,
                      let angle = angle else { return }
                Actions.appendBeam(i: iNode, j: jNode, angle: angle, section: selectedSectionId, material: selectedMaterialId, store: store)
                id = store.model.beams.count + 1
            })
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
            .frame(width: 170)
        Divider()
        MakeBeamView()
            .frame(width: 300)
    }
    .environmentObject(Store.debug)
}
