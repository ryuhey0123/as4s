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
        case section = "Section"
        case material = "Material"
    }
    
    var body: some View {
        VStack {
            HStack {
                CommandItem(command: .node, systemName: "circle.grid.2x1", item: $commandItem)
                CommandItem(command: .beam, systemName: "line.diagonal", item: $commandItem)
                CommandItem(command: .support, systemName: "triangle", item: $commandItem)
                CommandItem(command: .section, systemName: "h.square", item: $commandItem)
                CommandItem(command: .material, systemName: "leaf", item: $commandItem)
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
                    case .section:
                        EmptyView()
                    case .material:
                        MakeMaterialView()
                }
            }
            
            Spacer()
        }
        .frame(maxHeight: .infinity)
    }
    
    struct CommandItem: View {
        let command: CommandItems
        let systemName: String
        
        @State private var toggle: Bool
        @Binding var item: CommandItems
        
        init(command: CommandItems, systemName: String, item: Binding<CommandItems>) {
            self.command = command
            self.systemName = systemName
            self.toggle = (command == item.wrappedValue)
            self._item = item
        }
        
        var body: some View {
            Toggle(isOn: $toggle, label: {
                Label(command.rawValue, systemImage: systemName)
                    .labelStyle(.iconOnly)
            })
            .toggleStyle(.button)
            .buttonStyle(.borderless)
            .padding(3)
            .onChange(of: toggle) {
                if toggle { item = command }
            }
            .onChange(of: item) {
                toggle = (item == command)
            }
        }
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
