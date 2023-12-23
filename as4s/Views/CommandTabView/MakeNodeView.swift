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
            Text("Node")
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
            
            SubmitButtom(cancelAction: {
                xValue = 0
                yValue = 0
                zValue = 0
            }, submitAction: {
                guard let xValue = xValue,
                      let yValue = yValue,
                      let zValue = zValue else { return }
                Actions.appendNode(position: .init(xValue, yValue, zValue), store: store)
                id = store.model.nodes.count + 1
            })
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
            .frame(width: 170)
        Divider()
        MakeNodeView()
            .frame(width: 300)
    }
    .environmentObject(Store.debug)
}
