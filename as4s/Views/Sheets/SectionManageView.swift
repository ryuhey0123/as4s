//
//  SectionManageView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/24.
//

import SwiftUI

struct SectionManageView: View {
    @EnvironmentObject var store: Store
    @State private var commandItem: SectionItems = .rectangle
    
    enum SectionItems: String {
        case rectangle
        case rectanglePipe
        case circular
        case circularPipe
        case shapeH
    }
    
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
                TableColumn("A") { row in
                    Text(row.A, format: .number)
                }
                TableColumn("Iy") { row in
                    Text(row.Iy, format: .number)
                }
                TableColumn("Iz") { row in
                    Text(row.Iz, format: .number)
                }
                TableColumn("J") { row in
                    Text(row.J, format: .number)
                }
                TableColumn("alphaY") { row in
                    Text(row.alphaY ?? 0.0, format: .number)
                }
                TableColumn("alphaZ") { row in
                    Text(row.alphaZ ?? 0.0, format: .number)
                }
            }
            Divider()
            VStack {
                HStack {
                    SimpleTabItem(item: $commandItem, systemName: "rectangle.portrait.fill", command: .rectangle)
                    SimpleTabItem(item: $commandItem, systemName: "rectangle.portrait", command: .rectanglePipe)
                    SimpleTabItem(item: $commandItem, systemName: "circle.fill", command: .circular)
                    SimpleTabItem(item: $commandItem, systemName: "circle", command: .circularPipe)
                    SimpleTabItem(item: $commandItem, systemName: "h.square", command: .shapeH)
                }
                .padding(.top, 5)
                .frame(height: 19)
                
                Divider()
                
                Group {
                    switch commandItem {
                        case .rectangle:
                            MakeRectangle()
                        case .rectanglePipe:
                            EmptyView()
                        case .circular:
                            EmptyView()
                        case .circularPipe:
                            EmptyView()
                        case .shapeH:
                            EmptyView()
                    }
                }
                .padding(.horizontal, 10)
            }
            .frame(width: 200)
        }
        .frame(minWidth: 500)
        .padding(.top, 5)
    }
}

#Preview {
    SectionManageView()
        .environmentObject(Store.debug)
}
