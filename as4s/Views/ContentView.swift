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
        } detail: {
            ZStack {
                MVCView(controller: store.controller)
                    .clearColor(Config.system.backGroundColor)
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
    
    private var importBigTestModel: some View {
        Button("Import Big Test Model") {
            Actions.importTestModel(store: store)
        }
    }
    
    private var buildSmallTestModel: some View {
        Button("Build Small Test Model") {
            Actions.addNode(id: 0, position: .init(x: 0, y: 0, z: 0), store: store)
            Actions.addNode(id: 1, position: .init(x: 500, y: 0, z: 0), store: store)
            Actions.addNode(id: 2, position: .init(x: 1000, y: 0, z: 0), store: store)
            Actions.addBeam(id: 0, i: 0, j: 1, store: store)
            Actions.addBeam(id: 1, i: 1, j: 2, store: store)
            
            store.model.elasticSec.append(contentsOf: [
                ElasticSection(secTag: 0, E: 2.05E5, A: 100E2, Iz: 100E4, Iy: 100E4, G: 100E4, J: 100E4),
            ])
            store.model.fixes.append(contentsOf: [
                Support(nodeTag: 0, constrValues: [1, 1, 1, 1, 1, 1]),
            ])
            store.model.masses.append(contentsOf: [
                Mass(nodeTag: 1, massValues: [0, 0, -1e3, 0, 0, 0]),
            ])
            store.model.linerTransfs.append(contentsOf: [
                Transformation(transfTag: 0, vecxzX: 0, vecxzY: 0, vecxzZ: -1),
            ])
            store.model.plainPatterns.append(contentsOf: [
//                OSPlainPattern(patternTag: 0, tsTag: 0, loads: [
//                    NodalLoad(nodeTag: 0, loadvalues: [0, 0, -10, 0, 0, 0]),
//                    NodalLoad(nodeTag: 1, loadvalues: [0, 0, -100.0, 0, 0, 0])
//                ])
            ])
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
