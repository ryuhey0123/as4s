//
//  as4sApp.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI

@main
struct as4sApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: as4sDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
