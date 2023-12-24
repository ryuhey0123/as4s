//
//  MakeSectionView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/24.
//

import SwiftUI

struct MakeSectionView: View {
    @EnvironmentObject var store: Store
    @Environment(\.dismiss) private var dismiss
    
    @State private var id: Int?
    @State private var label: String = ""
    @State private var width: Float?
    @State private var height: Float?
    
    let labelWidth: CGFloat = 50
    
    var body: some View {
        HStack(alignment: .top, spacing: -1.0) {
            Table(store.model.sections) {
                TableColumn("ID") { row in
                    Text(row.id, format: .number)
                }
                TableColumn("Label") { row in
                    Text(row.label)
                }
                TableColumn("Type") { row in
                    Text(row.type.rawValue)
                }
            }
            VStack {
                Text("Rectangle Shape")
                    .font(.headline)
                Form {
                    InputIntValueField(value: $id, label: "ID", labelWidth: labelWidth)
                    InputStringValueField(value: $label, label: "Label", labelWidth: labelWidth)
                    InputFloatValueField(value: $width, label: "Width", labelWidth: labelWidth)
                    InputFloatValueField(value: $height, label: "Height", labelWidth: labelWidth)
                }
                SubmitButtom(cancelAction: {
                    
                }, submitAction: {
                    
                })
            }
            .padding()
            .frame(width: 200)
        }
        .frame(minWidth: 500)
    }
}

#Preview {
    MakeSectionView()
        .environmentObject(Store.debug)
}
