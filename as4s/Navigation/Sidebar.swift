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
        VStack(alignment: .leading) {
            Section("Model") {
                Toggle(isOn: $store.scene.modelLayer.isShown, label: { Text("Model") })
                Toggle(isOn: $store.scene.modelLayer.node.isShown, label: { Text("Node") })
                Toggle(isOn: $store.scene.modelLayer.beam.isShown, label: { Text("Beam") })
                Toggle(isOn: $store.scene.modelLayer.support.isShown, label: { Text("Suppot") })
            }
            Section("Label") {
                Toggle(isOn: $store.scene.modelLayer.nodeLabel.isShown, label: { Text("Node") })
                Toggle(isOn: $store.scene.modelLayer.beamLabel.isShown, label: { Text("Beam") })
            }
            Section("Load") {
                Toggle(isOn: $store.scene.loadLayer.isShown, label: { Text("Load") })
                Toggle(isOn: $store.scene.loadLayer.nodal.isShown, label: { Text("Nodal") })
            }
            Section("PostProcess") {
                Toggle(isOn: $store.scene.forceLayer.isShown, label: { Text("Force") })
                HStack {
                    Toggle(isOn: $store.scene.forceLayer.vX.isShown, label: { Text("Vx") })
                    Toggle(isOn: $store.scene.forceLayer.vY.isShown, label: { Text("Vy") })
                    Toggle(isOn: $store.scene.forceLayer.vZ.isShown, label: { Text("Vz") })
                }
                HStack {
                    Toggle(isOn: $store.scene.forceLayer.mX.isShown, label: { Text("Mx") })
                    Toggle(isOn: $store.scene.forceLayer.mY.isShown, label: { Text("My") })
                    Toggle(isOn: $store.scene.forceLayer.mZ.isShown, label: { Text("Mz") })
                }
                Toggle(isOn: $store.scene.dispModelLayer.isShown, label: { Text("Displacement") })
            }
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
            Actions.buildSmallModel(store: store)
        }
    }
    
    private var buildAnalyzeCommand: some View {
        Button("Analyze") {
            Actions.analayze(store: store)
        }
    }
}

#Preview {
    Sidebar()
        .environmentObject(Store())
        .frame(height: 500)
}
