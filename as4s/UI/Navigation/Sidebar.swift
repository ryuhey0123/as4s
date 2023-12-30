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
        VSplitView {
            CommandTabView()
                .frame(minHeight: 50, maxHeight: .infinity)
            
            Divider()
            
            VisiableToggle()
                .frame(minHeight: 50, maxHeight: .infinity)
            
            Divider()
            
            HStack {
                Button("Small") {
                    Actions.buildDebugModel(store: store)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                
                Button("Big") {
                    Actions.importTestModel(store: store)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Button("Analyze") {
                Actions.analayze(store: store, encoding: false)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
            
            Button("Encode/Analyze") {
                Actions.analayze(store: store)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}


fileprivate struct VisiableToggle: View {
    @EnvironmentObject var store: Store
    @State private var currentId: UUID = UUID()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Section("Caption") {
                    Toggle(isOn: $store.scene.captionLayer.globalCoord.isShown) {
                        Text("Global Coord")
                    }
                    Toggle(isOn: $store.scene.captionLayer.beamCoord.isShown) {
                        Text("Beam Coord")
                    }
                }
                Section("Model") {
                    Toggle(isOn: $store.scene.modelLayer.isShown) {
                        Text("Model")
                    }
                    Toggle(isOn: $store.scene.modelLayer.node.isShown) {
                        Text("Node")
                    }
                    Toggle(isOn: $store.scene.modelLayer.beam.isShown) {
                        Text("Beam")
                    }
                    Toggle(isOn: $store.scene.modelLayer.support.isShown) {
                        Text("Suppot")
                    }
                }
                Section("Label") {
                    Toggle(isOn: $store.scene.modelLayer.nodeLabel.isShown) {
                        Text("Node")
                    }
                    Toggle(isOn: $store.scene.modelLayer.beamLabel.isShown) {
                        Text("Beam")
                    }
                }
                Section("Load") {
                    Toggle(isOn: $store.scene.loadLayer.isShown) {
                        Text("Load")
                    }
                    Toggle(isOn: $store.scene.loadLayer.nodal.isShown) {
                        Text("Nodal")
                    }
                }
                
                Section("PostProcess") {
                    Picker("Result", selection: $currentId) {
                        ForEach(store.scene.results, id: \.id) { result in
                            Text(result.label ?? "Test")
                        }
                    }
                    
                    if let i = store.scene.results.firstIndex(where: { $0.id == currentId }) {
                        Toggle(isOn: $store.scene.results[i].beamForce.isShown) {
                            Text("Force")
                        }
                        
                        HStack {
                            Toggle(isOn: $store.scene.results[i].beamForce.vX.isShown, label: { Text("Vx") })
                            Toggle(isOn: $store.scene.results[i].beamForce.vY.isShown, label: { Text("Vy") })
                            Toggle(isOn: $store.scene.results[i].beamForce.vZ.isShown, label: { Text("Vz") })
                        }
                        HStack {
                            Toggle(isOn: $store.scene.results[i].beamForce.mX.isShown, label: { Text("Mx") })
                            Toggle(isOn: $store.scene.results[i].beamForce.mY.isShown, label: { Text("My") })
                            Toggle(isOn: $store.scene.results[i].beamForce.mZ.isShown, label: { Text("Mz") })
                        }
                        Button("Displacement") {
                            store.scene.results[i].disp.isShown.toggle()
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity,  alignment: .leading)
        }
    }
}

#Preview {
    Sidebar()
        .environmentObject(Store.debug)
        .frame(width: 250, height: 800)
}

#Preview("PostProcess") {
    VisiableToggle()
        .environmentObject(Store.debug)
        .frame(width: 250, height: 800)
}
