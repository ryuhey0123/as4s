//
//  MakeSupportView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct MakeSupportView: View {
    @EnvironmentObject var store: Store
    
    @State private var nodeIds: [Int] = []
    
    @State private var tx: Bool = false
    @State private var ty: Bool = false
    @State private var tz: Bool = false
    @State private var rx: Bool = false
    @State private var ry: Bool = false
    @State private var rz: Bool = false
    
    var body: some View {
        VStack {
            Text("Support")
                .font(.headline)
                .padding(.bottom, 20)
            Form {
                InputIntValuesField(array: $nodeIds)
                    .disabled(true)
                    .padding(.bottom, 20)
                
                Section {
                    HStack {
                        Toggle("Tx", isOn: $tx)
                        Toggle("Ty", isOn: $ty)
                        Toggle("Tz", isOn: $tz)
                    }
                    HStack {
                        Toggle("Rx", isOn: $rx)
                        Toggle("Ry", isOn: $ry)
                        Toggle("Rz", isOn: $rz)
                    }
                } header: {
                    Text("Constraints")
                        .font(.subheadline)
                }
            }
            
            SubmitButtom(cancelAction: {
                tx = false
                ty = false
                tz = false
                rx = false
                ry = false
                rz = false
            }, submitAction: {
                let values: [Int] = [tx, ty, tz, rx, ry, rz].map { $0 ? 1 : 0 }
                for nodeId in nodeIds {
                    Actions.addSupport(nodeId: nodeId, constrValues: values, store: store)
                }
            })
        }
        .padding(.trailing)
        .onChange(of: store.selectedNodes) {
            nodeIds = store.selectedNodes.map { $0.id }
        }
    }
}

#Preview {
    HStack {
        MakeSupportView()
            .environmentObject(Store())
            .frame(width: 170)
        MakeSupportView()
            .environmentObject(Store())
            .frame(width: 300)
    }
}
