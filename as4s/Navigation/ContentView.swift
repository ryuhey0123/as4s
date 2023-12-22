//
//  ContentView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import OpenSeesCoder
import SplitView

struct ContentView: View {
    @EnvironmentObject var store: Store
    
    @State private var showingInspector: Bool = false
    @State private var showingTransform: Bool = false
    @State private var showingInformation: Bool = true
    
    @State private var hide = SideHolder()
    
    @State private var showingAccesary: Bool = true
    @State private var showingOutput: Bool = true
    @State private var showingInput: Bool = true
    
    var body: some View {
        NavigationSplitView {
            Sidebar()
        } detail: {
            VStack(spacing: -1.0) {
                VSplit(top: {
                    VStack(spacing: -1.0) {
                        ModelView(store: store)
                            .onAppear {
                                Actions.addCoordinate(store: store)
                            }
                        Divider()
                    }
                }, bottom: {
                    VStack(spacing: -1.0) {
                        Divider()
                        InformationView(output: $store.openSeesStdErr, input: $store.openSeesInput, showingOutput: $showingOutput, showingInput: $showingInput)
                    }
                })
                .hide(hide)
                .splitter { CustomSplitter(hide: $hide, showingAccesary: $showingAccesary) }
                .fraction(0.75)
                .constraints(minPFraction: 0.3, minSFraction: 0.25)
                
                if showingAccesary {
                    Divider()
                    InformationAccessory(showingOutput: $showingOutput, showingInput: $showingInput)
                }
            }
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
