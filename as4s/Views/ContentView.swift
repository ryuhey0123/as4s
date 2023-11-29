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
            addBeam
        } detail: {
            ZStack {
                MVCView(controller: store.controller)
            }
        }
        .onAppear {
            store.updateView()
            
            Actions.addCoordinate(store: store)
        }
    }
    
    private var addPoint: some View {
        Button("Add Random Point") {
            Actions.addNode(at: .random(in: -1...1), store: store)
        }
    }
    
    private var addBeam: some View {
        Button("Add Random Beam") {
            Actions.addBeam(i: .random(in: -1...1), j: .random(in: -1...1), store: store)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
