//
//  ModelCommands.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI

struct ModelCommands: Commands {
    @Environment(\.openWindow) var openWindow
    @FocusedValue(\.showTransform) private var showPreview
    
    var body: some Commands {
        CommandMenu("Model") {
            Button {
                showPreview?.wrappedValue = true
            } label: {
                Label("Transform...", systemImage: "plus")
            }
            .keyboardShortcut("m", modifiers: .command)
        }
        
        CommandMenu("Table") {
            Button {
                openWindow(id: "table-nodes")
            } label: {
                Label("Node Tabel...", systemImage: "tablecells")
            }
        }
    }
}
