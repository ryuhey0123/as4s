//
//  ContentView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import OpenSeesCoder

struct ContentView: View {
    @EnvironmentObject var store: Store
    @State private var showingInspector: Bool = false
    @State private var showingTransform: Bool = false
    
    var body: some View {
        NavigationSplitView {
            Sidebar()
        } detail: {
            ModelView(store: store)
                .onAppear {
                    Actions.addCoordinate(store: store)
                }
        }
        .inspector(isPresented: $showingInspector) {
            ObjectInspector(selectedObjects: $store.selectedObjects)
                .inspectorColumnWidth(min: 200, ideal: 200, max: 300)
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button {
                    showingInspector.toggle()
                } label: {
                    Label("Inspector toggle", systemImage: "info.circle")
                }
            }
        }
        .onExitCommand(perform: {
            Actions.unselectAll(store: store)
        })
        .focusedSceneValue(\.showTransform, $showingTransform)
        .sheet(isPresented: $showingTransform) {
            TransformView()
        }
    }
    
    var addPoint: some View {
        Button("Add Random Point") {
            Actions.appendNode(position: .random(in: -10000...10000), store: store)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
