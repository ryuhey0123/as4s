//
//  Sidebar.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/16.
//

import SwiftUI

struct Sidebar: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        VStack {
            visiableToggle
            addPoint
            importBigTestModel
            buildSmallTestModel
            buildAnalyzeCommand
        }
    }
    
    private var visiableToggle: some View {
        Section("Label") {
            Toggle(isOn: $store.scene.nodeLabelVisiable, label: { Text("Node") })
        }
    }
    
    var addPoint: some View {
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
            Actions.addNode(id: 1, position: .init(x: -500, y: -500, z:    0), store: store)
            Actions.addNode(id: 2, position: .init(x:  500, y: -500, z:    0), store: store)
            Actions.addNode(id: 3, position: .init(x: -500, y:  500, z:    0), store: store)
            Actions.addNode(id: 4, position: .init(x:  500, y:  500, z:    0), store: store)
            Actions.addNode(id: 5, position: .init(x: -500, y: -500, z: 1000), store: store)
            Actions.addNode(id: 6, position: .init(x:  500, y: -500, z: 1000), store: store)
            Actions.addNode(id: 7, position: .init(x: -500, y:  500, z: 1000), store: store)
            Actions.addNode(id: 8, position: .init(x:  500, y:  500, z: 1000), store: store)
            
            Actions.addBeam(id:  1, i: 1, j: 2, store: store)
            Actions.addBeam(id:  2, i: 2, j: 4, store: store)
            Actions.addBeam(id:  3, i: 3, j: 4, store: store)
            Actions.addBeam(id:  4, i: 1, j: 3, store: store)
            
            Actions.addBeam(id:  5, i: 5, j: 6, store: store)
            Actions.addBeam(id:  6, i: 6, j: 8, store: store)
            Actions.addBeam(id:  7, i: 7, j: 8, store: store)
            Actions.addBeam(id:  8, i: 5, j: 7, store: store)
            
            Actions.addBeam(id:  9, i: 1, j: 5, store: store)
            Actions.addBeam(id: 10, i: 2, j: 6, store: store)
            Actions.addBeam(id: 11, i: 4, j: 8, store: store)
            Actions.addBeam(id: 12, i: 3, j: 7, store: store)
            
            store.model.fixes.append(contentsOf: [
                Support(nodeTag: 1, constrValues: [1, 1, 1, 0, 0, 0]),
                Support(nodeTag: 2, constrValues: [1, 1, 1, 0, 0, 0]),
                Support(nodeTag: 3, constrValues: [1, 1, 1, 0, 0, 0]),
                Support(nodeTag: 4, constrValues: [1, 1, 1, 0, 0, 0]),
            ])
            
            Actions.addNodalLoad(id: 5, force: [10e3, 0, 0, 0, 0, 0], store: store)
            Actions.addNodalLoad(id: 6, force: [0, 10e3, 0, 0, 0, 0], store: store)
        }
    }
    
    private var buildAnalyzeCommand: some View {
        Button("Analyze") {
            Actions.exexuteOpenSees(store: store)
            Actions.updateNodeDisp(store: store)
        }
    }
}

#Preview {
    Sidebar()
        .environmentObject(Store())
}
