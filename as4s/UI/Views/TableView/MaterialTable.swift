//
//  MaterialTable.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct MaterialTable: View {
    @Binding var materials: [Material]
    
    var body: some View {
        Table(materials) {
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
    }
}

#Preview {
    MaterialTable(materials: .constant(Store.debug.model.materials))
}
