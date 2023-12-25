//
//  ModelCommands.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI

struct ModelCommands: Commands {
    @Environment(\.openWindow) private var openWindow
    @FocusedValue(\.store) private var store
    @FocusedValue(\.showTransform) private var showTransform
    @FocusedValue(\.showSectionManager) private var showSectionManager
    @FocusedValue(\.showMaterialManager) private var showMaterialManager
    
    var body: some Commands {
        CommandMenu("Model") {
            Button {
                showTransform?.wrappedValue = true
            } label: {
                Label("Transform...", systemImage: "plus")
            }
            .keyboardShortcut("m", modifiers: .command)
            
            Button {
                showSectionManager?.wrappedValue = true
            } label: {
                Label("Section...", systemImage: "plus")
            }
            .keyboardShortcut("s", modifiers: [.command, .control])
            
            Button {
                showMaterialManager?.wrappedValue = true
            } label: {
                Label("Material...", systemImage: "plus")
            }
            .keyboardShortcut("m", modifiers: [.command, .control])
        }
        
        CommandMenu("Table") {
            Button {
                openWindow(value: store!.id)
            } label: {
                Label("Node Tabel...", systemImage: "tablecells")
            }
            .disabled(store == nil)
        }
    }
}
