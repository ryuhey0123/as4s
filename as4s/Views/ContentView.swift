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
            importTestModel
        } detail: {
            ZStack {
                MVCView(controller: store.controller)
                    .clearColor(AS4Config.system.backGroundColor)
            }
        }
        .onAppear {
            store.updateView()
            
            Actions.addCoordinate(store: store)
        }
    }
    
    private var addPoint: some View {
        Button("Add Random Point") {
            Actions.addNode(at: .random(in: -10000...10000), store: store)
        }
    }
    
    private var addBeam: some View {
        Button("Add Random Beam") {
            let i: double3 = .random(in: -10000...10000)
            let j: double3 = .random(in: -10000...10000)
            Actions.addNode(at: i, store: store)
            Actions.addNode(at: j, store: store)
            Actions.addBeam(i: i, j: j, store: store)
        }
    }
    
    private var importTestModel: some View {
        Button("Import Test Model") {
            Actions.importTestModel(store: store)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
