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
            importSmallTestModel
            importBigTestModel
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
            Actions.appendNode(position: .random(in: -10000...10000), store: store)
        }
    }
    
    private var importSmallTestModel: some View {
        Button("Import Small Test Model") {
            Actions.addNode(id: 1, position: .init([0, 0, 0]), store: store)
            Actions.addNode(id: 2, position: .init([3000, 0, 0]), store: store)
            let node1 = store.model.nodes.first(where: { $0.id == 1 })!
            let node2 = store.model.nodes.first(where: { $0.id == 2 })!
            Actions.addBeam(id: 1, i: node1, j: node2, store: store)
            Actions.addSupport(at: 1, constraint: .fix, store: store)
            Actions.addPointLoad(at: 2, value: [0, 0, -1000, 0, 0, 0], store: store)
        }
    }
    
    private var importBigTestModel: some View {
        Button("Import Big Test Model") {
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
