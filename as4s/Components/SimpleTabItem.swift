//
//  SimpleTabItem.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/25.
//

import SwiftUI

struct SimpleTabItem<T>: View where T : RawRepresentable & Equatable, T.RawValue : StringProtocol {
    @Binding var item: T
    let systemName: String
    let command: T
    
    @State private var toggle: Bool = false
    
    init(item: Binding<T>, systemName: String, command: T) {
        self.command = command
        self.systemName = systemName
        self._item = item
    }
    
    var body: some View {
        Button {
            if command != item {
                toggle.toggle()
            }
        } label: {
            Label(command.rawValue, systemImage: systemName)
                .labelStyle(.iconOnly)
                .foregroundStyle(toggle ? Color.accentColor : Color.secondary)
        }
        .buttonStyle(.borderless)
        .padding(3)
        .onChange(of: toggle) {
            if toggle { item = command }
        }
        .onChange(of: item) {
            toggle = (item == command)
        }
        .onAppear {
            toggle = (command == $item.wrappedValue)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var commandItem: CommandItems = .node
        
        enum CommandItems: String {
            case node = "Node"
            case beam = "Beam"
            case support = "Support"
            case section = "Section"
            case material = "Material"
        }
        
        var body: some View {
            HStack {
                SimpleTabItem(item: $commandItem, systemName: "circle.grid.2x1", command: .node)
                SimpleTabItem(item: $commandItem, systemName: "line.diagonal",   command: .beam)
                SimpleTabItem(item: $commandItem, systemName: "triangle",        command: .support)
                SimpleTabItem(item: $commandItem, systemName: "h.square",        command: .section)
                SimpleTabItem(item: $commandItem, systemName: "leaf",            command: .material)
            }
            .padding()
        }
    }
    return PreviewWrapper()
}
