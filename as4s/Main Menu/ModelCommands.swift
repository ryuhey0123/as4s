//
//  ModelCommands.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI

struct ModelCommands: Commands {
    @FocusedValue(\.store) var store
    @Environment(\.openWindow) var openWindow
    
    var body: some Commands {
        CommandMenu("Model") {
            Button {
                openWindow(id: "add-node")
            } label: {
                Label("Add Node...", systemImage: "plus")
            }
            Button {
                openWindow(id: "add-node")
            } label: {
                Label("Add Beam...", systemImage: "plus")
            }
        }
    }
}
