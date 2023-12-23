//
//  MakeNodeView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/21.
//

import SwiftUI

struct MakeNodeView: View {
    @EnvironmentObject var store: Store
    
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
                    xValue = 0
                    yValue = 0
                    zValue = 0
                } label: {
                    Text("Reset")
                }
                Button {
                    guard let xValue = xValue,
                          let yValue = yValue,
                          let zValue = zValue else { return }
                    Actions.appendNode(position: .init(xValue, yValue, zValue), store: store)
                    id = store.model.nodes.count + 1
                } label: {
                    Text("OK")
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .padding(.trailing)
        .onAppear {
            id = store.model.nodes.count + 1
        }
    }
}

#Preview {
    HStack {
        MakeNodeView()
            .environmentObject(Store())
            .frame(width: 170)
        Divider()
        MakeNodeView()
            .environmentObject(Store())
            .frame(width: 300)
    }
}
