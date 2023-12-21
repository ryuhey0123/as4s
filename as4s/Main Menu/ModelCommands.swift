//
//  ModelCommands.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import SwiftUI

struct ModelCommands: Commands {
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
    }
}
