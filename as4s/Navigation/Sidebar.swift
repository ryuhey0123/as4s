//
//  Sidebar.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/16.
//

import SwiftUI

struct Sidebar: View {
    @EnvironmentObject var store: Store
    
    @State private var commandItem: CommnadItem = .node
    
    enum CommnadItem {
        case node, beam
    }
    
    var body: some View {
        VSplitView {
            CommandTabView()
                .frame(minHeight: 50, maxHeight: .infinity)
            
            Divider()
            
            visiableToggle
                .frame(minHeight: 50, maxHeight: .infinity)
            
            Divider()
            
            buildAnalyzeCommand
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .onAppear {
            Actions.buildDebugModel(store: store)
        }
    }
    
    private var visiableToggle: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Section("Caption") {
                    Toggle(isOn: $store.scene.captionLayer.globalCoord.isShown, label: { Text("Global Coord") })
                    Toggle(isOn: $store.scene.captionLayer.beamCoord.isShown, label: { Text("Beam Coord") })
                }
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
                    
                    Button("Displacement") {
                        store.scene.dispModelLayer.isHidden.toggle()
                        store.scene.modelLayer.isUnEnabled.toggle()
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity,  alignment: .leading)
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
            Actions.buildDebugModel(store: store)
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
        .environmentObject(Store.debug)
        .frame(width: 250, height: 800)
}
