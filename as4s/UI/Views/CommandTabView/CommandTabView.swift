//
//  CommandTabView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI

struct CommandTabView: View {
    @State private var commandItem: CommandItems = .node
    
    enum CommandItems: String {
        case node = "Node"
        case beam = "Beam"
        case support = "Support"
    }
    
    var body: some View {
        VStack {
            HStack {
                SimpleTabItem(item: $commandItem, systemName: "circle.grid.2x1", command: .node)
                SimpleTabItem(item: $commandItem, systemName: "line.diagonal",   command: .beam)
                SimpleTabItem(item: $commandItem, systemName: "triangle",        command: .support)
            }
            .padding(.top, 5)
            .frame(height: 25)
            
            Divider()
            
            ScrollView {
                switch commandItem {
                    case .node:
                        MakeNodeView()
                    case .beam:
                        MakeBeamView()
                    case .support:
                        MakeSupportView()
                }
            }
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    HStack(spacing: -1.0) {
        CommandTabView()
            .frame(width: 170, height: 500)
        Divider()
        CommandTabView()
            .frame(width: 300, height: 500)
    }
    .environmentObject(Store.debug)
}
