//
//  MakeNodeView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/21.
//

import SwiftUI

struct MakeNodeView: View {
    @State private var id: Int?
    @State private var xValue: Float?
    @State private var yValue: Float?
    @State private var zValue: Float?
    
    var body: some View {
        VStack {
            Text("Make Node")
                .font(.headline)
                .padding(.bottom, 20)
            Form {
                InputIntValueField(value: $id, label: "ID", systemImage: "number.square")
                    .disabled(true)
                    .padding(.bottom, 20)
                
                Section {
                    InputFloatValueField(value: $xValue, label: "X")
                    InputFloatValueField(value: $yValue, label: "Y")
                    InputFloatValueField(value: $zValue, label: "Z")
                        .padding(.bottom, 20)
                } header: {
                    Text("Coordinate")
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
        MakeNodeView()
            .frame(width: 170)
        Divider()
        MakeNodeView()
            .frame(width: 300)
    }
}
