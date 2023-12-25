//
//  NodeTable.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct NodeTable: View {
    @Binding var nodes: Set<Node>
    
    var body: some View {
        Table(Array(nodes)) {
            TableColumn("ID") { row in
                Text(row.id, format: .number)
            }
            TableColumn("X") { row in
                Text(row.position.x, format: .number)
            }
            TableColumn("Y") { row in
                Text(row.position.y, format: .number)
            }
            TableColumn("Z") { row in
                Text(row.position.z, format: .number)
            }
        }
    }
}

#Preview {
    NodeTable(nodes: .constant(Store.debug.model.nodes))
}
