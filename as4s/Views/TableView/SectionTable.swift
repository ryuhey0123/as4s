//
//  SectionTable.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct SectionTable: View {
    @Binding var sections: [RectangleSection]
    
    var body: some View {
        Table(sections) {
            TableColumn("ID") { row in
                Text(row.id, format: .number)
            }
            TableColumn("Width") { row in
                Text(row.width, format: .number)
            }
            TableColumn("Height") { row in
                Text(row.height, format: .number)
            }
            TableColumn("type") { row in
                Text(row.type.rawValue)
            }
            TableColumn("Area") { row in
                Text(row.A, format: .number)
            }
            TableColumn("Iz") { row in
                Text(row.Iz, format: .number)
            }
            TableColumn("Iy") { row in
                Text(row.Iy, format: .number)
            }
            TableColumn("J") { row in
                Text(row.J, format: .number)
            }
            TableColumn("AlphaY") { row in
                Text(row.alphaY ?? 0.0, format: .number)
            }
            TableColumn("AlphaZ") { row in
                Text(row.alphaZ ?? 0.0, format: .number)
            }
        }
    }
}

#Preview {
    SectionTable(sections: .constant(Store.debug.model.reactangle))
}
