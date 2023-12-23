//
//  NodeTable.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct NodeTable: View {
    @Binding var nodes: [Node]
    
    var body: some View {
        Table(nodes) {
            TableColumn("ID") { node in
                Text(node.id, format: .number)
            }
            TableColumn("X") { node in
                Text(node.position.x, format: .number)
            }
            TableColumn("Y") { node in
                Text(node.position.y, format: .number)
            }
            TableColumn("Z") { node in
                Text(node.position.z, format: .number)
            }
        }
    }
}

#Preview {
    NodeTable(nodes: .constant(Store.debug.model.nodes))
}
