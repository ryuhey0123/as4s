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
    @State var lastNodeId = 0

    var body: some View {
        NavigationSplitView {
            addPoint
            importTestModel
            linerStaticAnalyzeButton
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
            Actions.addNode(id: lastNodeId, position: .random(in: -10000...10000), store: store)
            lastNodeId += 1
        }
    }
    
    private var importTestModel: some View {
        Button("Import Test Model") {
            Actions.importTestModel(store: store)
        }
    }
    
    private var linerStaticAnalyzeButton: some View {
        Button("Liner Static Analyze") {
            Actions.linerStaticAnalyze(store: store)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
