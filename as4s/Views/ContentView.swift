//
//  ContentView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

struct ContentView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        NavigationSplitView {
            addPoint
        } detail: {
            ZStack {
                MVCView(controller: &store.controller)
                Gesture(store: store)
            }
        }
    }
    
    private var addPoint: some View {
        Button("Add Point") { Actions.addPoint(store: store) }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
