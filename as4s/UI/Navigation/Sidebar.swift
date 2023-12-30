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
            
            VisiableToggles()
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

fileprivate struct VisiableToggles: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                CaptionVisiable()
                ModelVisiable()
                LoadVisiable()
                ResultPicker()
            }
            .padding()
            .frame(maxWidth: .infinity,  alignment: .leading)
        }
    }
}

fileprivate struct VisiableToggle: View {
    var title: String
    @Binding var value: Bool
    var state: Bool = true
    
    var body: some View {
        Toggle(isOn: $value) {
            Text(title)
        }.onAppear {
            value = state
        }
    }
}

fileprivate struct CaptionVisiable: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        Section("Caption") {
            VisiableToggle(title: "Global Coord",
                           value: $store.scene.captionLayer.globalCoord.isShown,
                           state: false)
            VisiableToggle(title: "Locale Coord",
                           value: $store.scene.captionLayer.beamCoord.isShown,
                           state: false)
        }
    }
}

fileprivate struct ModelVisiable: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        Section("Model") {
            VisiableToggle(title: "Model",
                           value: $store.scene.modelLayer.isShown)
            VisiableToggle(title: "Node",
                           value: $store.scene.modelLayer.node.isShown)
            VisiableToggle(title: "Beam",
                           value: $store.scene.modelLayer.beam.isShown)
            VisiableToggle(title: "Suppot",
                           value: $store.scene.modelLayer.support.isShown)
        }
        
        Section("Label") {
            VisiableToggle(title: "Node",
                           value: $store.scene.modelLayer.nodeLabel.isShown,
                           state: false)
            VisiableToggle(title: "Beam",
                           value: $store.scene.modelLayer.beamLabel.isShown,
                           state: false)
        }
    }
}

fileprivate struct LoadVisiable: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        Section("Load") {
            VisiableToggle(title: "Load",
                           value: $store.scene.loadLayer.isShown,
                           state: false)
            VisiableToggle(title: "Nodal",
                           value: $store.scene.loadLayer.nodal.isShown,
                           state: false)
        }
    }
}

fileprivate struct ResultPicker: View {
    @EnvironmentObject var store: Store
    @State private var currentId: Int = 0
    
    var body: some View {
        Section("Result") {
            Picker("Load Case", selection: $currentId) {
                ForEach(store.scene.results.indices, id: \.self) { index in
                    Text(store.scene.results[index].label ?? "Test").tag(index)
                }
            }
            
            if store.scene.results.indices.contains(currentId) {
                BeamColumnResultVisiable(result: $store.scene.results[currentId])
            } else {
                Text("No results available")
            }
     
        }
    }
}

fileprivate struct BeamColumnResultVisiable: View {
    @Binding var result: ResultLayer
    
    var body: some View {
        Section {
            VisiableToggle(title: "Displacement",
                           value: $result.disp.isShown,
                           state: false)
            VisiableToggle(title: "Force",
                           value: $result.beamForce.isShown,
                           state: false)
            HStack {
                VisiableToggle(title: "Vx",
                               value: $result.beamForce.vX.isShown,
                               state: false)
                VisiableToggle(title: "Vy",
                               value: $result.beamForce.vY.isShown,
                               state: false)
                VisiableToggle(title: "Vz",
                               value: $result.beamForce.vZ.isShown,
                               state: false)
            }
            HStack {
                VisiableToggle(title: "Mx",
                               value: $result.beamForce.mX.isShown,
                               state: false)
                VisiableToggle(title: "My",
                               value: $result.beamForce.mY.isShown,
                               state: false)
                VisiableToggle(title: "Mz",
                               value: $result.beamForce.mZ.isShown,
                               state: false)
            }
        }
    }
}


// MARK: - Previews

#Preview {
    Sidebar()
        .environmentObject(Store.debug)
        .frame(width: 250, height: 800)
}

#Preview("Visiable") {
    VisiableToggles()
        .environmentObject(Store.debug)
        .frame(width: 250, height: 800)
}

#Preview("Result") {
    ResultPicker()
        .frame(width: 300)
        .padding()
}

