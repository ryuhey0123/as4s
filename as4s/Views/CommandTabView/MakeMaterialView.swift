//
//  MakeMaterialView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct MakeMaterialView: View {
    @EnvironmentObject var store: Store
    
    @State private var id: Int?
    @State private var label: String = ""
    @State private var E: Float?
    @State private var G: Float?
    
    var body: some View {
        VStack {
            Text("Make Material")
                .font(.headline)
                .padding(.bottom, 20)
            Form {
                InputIntValueField(value: $id, label: "ID", systemImage: "1.square")
                    .disabled(true)
                    .padding(.bottom, 20)
                
                Section {
                    InputStringValueField(value: $label, label: "Label")
                    InputFloatValueField(value: $E, label: "E")
                    InputFloatValueField(value: $G, label: "G")
                        .padding(.bottom, 20)
                }
            }
            HStack {
                Spacer()
                Button {
                    label = ""
                    E = nil
                    G = nil
                } label: {
                    Text("Reset")
                }
                Button {
                    guard let E = E,
                          let G = G else { return }
                    Actions.appendMaterial(label: label, E: E, G: G, store: store)
                    id = store.model.materials.count + 1
                } label: {
                    Text("OK")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .padding(.trailing)
        .onAppear {
            id = store.model.materials.count + 1
        }
    }
}

#Preview {
    HStack {
        MakeMaterialView()
            .environmentObject(Store())
            .frame(width: 170)
        MakeMaterialView()
            .environmentObject(Store())
            .frame(width: 300)
    }
}
