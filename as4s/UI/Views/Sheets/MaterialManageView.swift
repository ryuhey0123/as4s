//
//  MaterialManageView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/25.
//

import SwiftUI

struct MaterialManageView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var store: Store
    
    let labelWidth: CGFloat = 50
    
    @State private var id: Int?
    @State private var label: String = ""
    @State private var E: Float?
    @State private var G: Float?
    
    var body: some View {
        HStack(alignment: .top, spacing: -1.0) {
            Table(store.model.materials) {
                TableColumn("ID") { row in
                    Text(row.id, format: .number)
                }
                TableColumn("Label") { row in
                    Text(row.label)
                }
                TableColumn("E") { row in
                    Text(row.E, format: .number)
                }
                TableColumn("G") { row in
                    Text(row.G, format: .number)
                }
            }
            
            Divider()
            
            VStack {
                Text("Material")
                    .font(.headline)
                Form {
                    InputIntValueField(value: $id, label: "ID", labelWidth: labelWidth)
                    InputStringValueField(value: $label, label: "Label", labelWidth: labelWidth)
                    InputFloatValueField(value: $E, label: "E", labelWidth: labelWidth)
                    InputFloatValueField(value: $G, label: "G", labelWidth: labelWidth)
                }
                SubmitButtom(cancelAction: {
                    dismiss()
                }, submitAction: {
                    
                })
            }
        }
        .frame(minWidth: 500)
        .padding(.top, 5)
    }
}

#Preview {
    MaterialManageView()
        .environmentObject(Store.debug)
}
