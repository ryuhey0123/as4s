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
    
    var body: some Commands {
        CommandMenu("Model") {
            Button {
                store!.showingTransformSheet = true
            } label: {
                Label("Transform...", systemImage: "plus")
            }
            .disabled(store == nil)
            .keyboardShortcut("m", modifiers: .command)
            
            Button {
                store!.showingSectionManagerSheet = true
            } label: {
                Label("Section...", systemImage: "plus")
            }
            .disabled(store == nil)
            .keyboardShortcut("s", modifiers: [.command, .control])
            
            Button {
                store!.showingMaterialManagerSheet = true
            } label: {
                Label("Material...", systemImage: "plus")
            }
            .disabled(store == nil)
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
