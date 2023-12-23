//
//  BeamColumnTable.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct BeamColumnTable: View {
    @Binding var beams: [BeamColumn]
    @State var selectedRows: Set<BeamColumn.ID> = Set<BeamColumn.ID>()
    
    var body: some View {
        Table(beams, selection: $selectedRows) {
            TableColumn("ID") { row in
                Text(row.id, format: .number)
            }
            TableColumn("i") { row in
                Text(row.iNode, format: .number)
            }
            TableColumn("j") { row in
                Text(row.jNode, format: .number)
            }
            TableColumn("Length") { row in
                Text(row.length, format: .number)
            }
            TableColumn("Section") { row in
                HStack {
                    Text("\(row.section.id)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text("\(row.section.label)")
                }
            }
            TableColumn("Material") { row in
                HStack {
                    Text("\(row.material.id)")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                    Text("\(row.material.label)")
                }
            }
            TableColumn("Angle") { row in
                Text(row.coordAngle, format: .number)
            }
            TableColumn("TransfTag(Opensees)") { row in
                Text(row.transfTag, format: .number)
            }
            TableColumn("SecTag(Opensees)") { row in
                Text(row.secTag, format: .number)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var beams = Store.debug.model.beams
        
        var body: some View {
            BeamColumnTable(beams: $beams)
        }
    }
    return PreviewWrapper()
}
