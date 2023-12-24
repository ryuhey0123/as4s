//
//  as4sApp.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI

@main
struct as4sApp: App {
    @StateObject var sharedStore = SharedStore()
    
    var body: some Scene {
        DocumentGroup(newDocument: { Store() }) { configuration in
            ContentView()
                .onAppear {
                    sharedStore.stores.append(configuration.document)
                }
                .focusedSceneValue(\.store, configuration.document)
        }
        .commands {
            ModelCommands()
        }
        
        WindowGroup(for: Store.ID.self) { $storeId in
            TableView(store: sharedStore.stores.first(where: { $0.id == storeId }) ?? .debug)
        }
        .commandsRemoved()
    }
}

extension FocusedValues {
    
    struct StoreFocusedValuesKey: FocusedValueKey {
        typealias Value = Store
    }
    
    struct ShowTransformKey: FocusedValueKey {
        typealias Value = Binding<Bool>
    }
    
    struct ShowMakeSectionKey: FocusedValueKey {
        typealias Value = Binding<Bool>
    }

    var store: Store? {
        get { self[StoreFocusedValuesKey.self] }
        set { self[StoreFocusedValuesKey.self] = newValue }
    }
    
    var showTransform: Binding<Bool>? {
        get { self[ShowTransformKey.self] }
        set { self[ShowTransformKey.self] = newValue }
    }
    
    var showMakeSection: Binding<Bool>? {
        get { self[ShowMakeSectionKey.self] }
        set { self[ShowMakeSectionKey.self] = newValue }
    }
}
