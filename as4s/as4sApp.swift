//
//  as4sApp.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI

@main
struct as4sApp: App {
    @StateObject private var sharedStore = SharedStore()
    
    var body: some Scene {
        DocumentGroup(newDocument: { Store() }) { configuration in
            ContentView()
                .onAppear {
                    sharedStore.stores.append(configuration.document)
                }
                .focusedSceneValue(\.store, configuration.document)
        }
    }
}

extension FocusedValues {
    struct StoreFocusedValues: FocusedValueKey {
        typealias Value = Store
    }

    var store: Store? {
        get {
            self[StoreFocusedValues.self]
        }
        set {
            self[StoreFocusedValues.self] = newValue
        }
    }
}
