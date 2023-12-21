//
//  MakeNodeView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/21.
//

import SwiftUI

struct MakeNodeView: View {
    @State private var id: Int = 1
    @State private var xValue: Float = 0.0
    @State private var yValue: Float = 0.0
    @State private var zValue: Float = 0.0
    
    var body: some View {
//        Form {
//            TextField(value: $id, format: .number) {
//                Label("ID", systemImage: "number.square.fill")
//            }
//            .disabled(true)
//            
//            HStack {
//                TextField(value: $xValue, format: .number) {
//                    Label("X ", systemImage: "number.square.fill")
//                }
//                TextField(value: $yValue, format: .number) {
//                    Label("Y ", systemImage: "number.square.fill")
//                }
//                TextField(value: $zValue, format: .number) {
//                    Label("Z ", systemImage: "number.square.fill")
//                }
        
        TextField("", value: $zValue, format: .number)
//            }
//            
//            HStack {
//                Spacer()
//                
//                Button {
//                    print("Chancel")
//                } label: {
//                    Text("Cancel")
//                }
//                
//                Button {
//                    print("OK")
//                } label: {
//                    Text("OK")
//                }
//                .buttonStyle(.borderedProminent)
//            }
//        }
//        .padding()
    }
}

#Preview {
    MakeNodeView()
}
