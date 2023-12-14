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

    var body: some View {
        NavigationSplitView {
            addPoint
            importBigTestModel
            buildSmallTestModel
            buildAnalyzeCommand
        } detail: {
            ZStack {
                MVCView(controller: store.controller)
                    .clearColor(Config.system.backGroundColor)
            }
        }
        .onAppear {
            Actions.addCoordinate(store: store)
        }
    }
    
    private var addPoint: some View {
        Button("Add Random Point") {
            Actions.appendNode(position: .random(in: -10000...10000), store: store)
        }
    }
    
    private var importBigTestModel: some View {
        Button("Big Test Model") {
            Actions.importTestModel(store: store)
        }
    }
    
    private var buildSmallTestModel: some View {
        Button("Small Test Model") {
            Actions.addNode(id: 1, position: .init(x: 0, y: 0, z: 0), store: store)
            Actions.addNode(id: 2, position: .init(x: 500, y: 0, z: 0), store: store)
            Actions.addNode(id: 3, position: .init(x: 1000, y: 0, z: 0), store: store)
            
            Actions.addBeam(id: 1, i: 1, j: 2, store: store)
            Actions.addBeam(id: 2, i: 2, j: 3, store: store)
            
            store.model.fixes.append(contentsOf: [
                Support(nodeTag: 1, constrValues: [1, 1, 1, 1, 1, 1]),
            ])
            
            store.model.plainPatterns.append(contentsOf: [
                OSPlainPattern(patternTag: 1, tsTag: 1, loads: [
                    NodalLoad(nodeTag: 3, loadvalues: [0, 0, -1e3, 0, 0, 0])
                ])
            ])
        }
    }
    
    private var buildAnalyzeCommand: some View {
        Button("Analyze") {
            let data = try! OSEncoder().encode(store.model)
            Actions.exexuteOpenSees(data: data, store: store)
            Actions.updateNodeDisp(store: store)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
