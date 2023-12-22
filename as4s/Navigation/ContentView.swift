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
    
    @State private var showingInspector: Bool = false
    @State private var showingTransform: Bool = false
    @State private var showingInformation: Bool = true
    
    var body: some View {
        NavigationSplitView {
            Sidebar()
        } detail: {
            VStack(spacing: -1.0) {
                VStack(spacing: -1.0) {
                    ModelView(store: store)
                        .onAppear {
                            Actions.addCoordinate(store: store)
                    }
                    Divider()
                    AccessoryView(showingInformation: $showingInformation)
                }
                if showingInformation {
                    Divider()
                    InformationView(output: $store.openSeesStdErr, input: $store.openSeesInput)
                }
            }
            .animation(.interactiveSpring, value: showingInformation)
            
        }
        .inspector(isPresented: $showingInspector) {
            ObjectInspector(selectedObjects: $store.selectedObjects)
                .inspectorColumnWidth(min: 200, ideal: 200, max: 300)
        }
        .toolbar {
            ToolbarItemGroup(placement: .automatic) {
                Button {
                    showingInspector.toggle()
                } label: {
                    Label("Inspector toggle", systemImage: "info.circle")
                }
            }
        }
        .onExitCommand(perform: {
            Actions.unselectAll(store: store)
        })
        .focusedSceneValue(\.showTransform, $showingTransform)
        .sheet(isPresented: $showingTransform) {
            TransformView()
        }
    }
    
    var addPoint: some View {
        Button("Add Random Point") {
            Actions.appendNode(position: .random(in: -10000...10000), store: store)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
        .frame(width: 1000)
}

struct AccessoryView: View {
    @Binding var showingInformation: Bool
    
    var body: some View {
        HStack {
            Text("Hello!")
                .foregroundStyle(.secondary)
            Spacer()
            Toggle(isOn: $showingInformation, label: {
                Label("Show Information", systemImage: "square.bottomthird.inset.filled")
                    .labelStyle(.iconOnly)
            })
            .toggleStyle(.button)
            .buttonStyle(.borderless)
        }
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}
