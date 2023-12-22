//
//  MakeBeamView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI

struct MakeBeamView: View {
    @State private var id: Int? = 1
    
    @State private var iNode: Int?
    @State private var jNode: Int?
    @State private var angle: Float?
    @State private var section: Int?
    
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
                    print("Cancel")
                } label: {
                    Text("Cancel")
                }
                Button {
                    print("OK")
                } label: {
                    Text("OK")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .padding(.trailing)
    }
}

#Preview {
    HStack {
        MakeBeamView()
            .frame(width: 170)
        Divider()
        MakeBeamView()
            .frame(width: 500)
    }
}
