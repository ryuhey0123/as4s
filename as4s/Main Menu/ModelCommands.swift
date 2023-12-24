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
    @FocusedValue(\.showMakeSection) private var showMakeSection
    
    var body: some Commands {
        CommandMenu("Model") {
            Button {
                showTransform?.wrappedValue = true
            } label: {
                Label("Transform...", systemImage: "plus")
            }
            .keyboardShortcut("m", modifiers: .command)
            
            Button {
                showMakeSection?.wrappedValue = true
            } label: {
                Label("Section...", systemImage: "plus")
            }
            .keyboardShortcut("s", modifiers: [.command, .control])
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
