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
    @State private var showingTransformSheet: Bool = false
    @State private var showingSectionManagerSheet: Bool = false
    @State private var showingMaterialManagerSheet: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationSplitView {
                Sidebar()
                    .frame(minWidth: 170)
            } detail: {
                Detail()
                    .toolbar {
                        ToolbarItemGroup(placement: .principal) {
                            ProgressBar(title: $store.progressTitle,
                                        subtitle: $store.progressSubtitle,
                                        progress: $store.progress,
                                        total: $store.progressEstimated,
                                        errors: $store.errorMessages,
                                        warnings: $store.warningMessages)
                                .frame(width: geometry.frame(in: .local).width * 0.4)
                            Spacer()
                        }
                        ToolbarItem(placement: .primaryAction) {
                            Button {
                                showingInspector.toggle()
                            } label: {
                                Label("Inspector toggle", systemImage: "info.circle")
                            }
                        }
                    }
                    .onAppear {
                        Actions.buildDebugModel(store: store)
                    }
            }
        }
        .inspector(isPresented: $showingInspector) {
            ObjectInspector(selectedNodes: $store.selectedNodes, selectedBeams: $store.selectedBeams)
        }
        .onExitCommand(perform: {
            Actions.unselectAll(store: store)
        })
        .focusedSceneValue(\.showTransform, $showingTransformSheet)
        .sheet(isPresented: $showingTransformSheet) {
            TransformView()
        }
        .focusedSceneValue(\.showSectionManager, $showingSectionManagerSheet)
        .sheet(isPresented: $showingSectionManagerSheet) {
            SectionManageView()
        }
        .focusedSceneValue(\.showMaterialManager, $showingMaterialManagerSheet)
        .sheet(isPresented: $showingMaterialManagerSheet) {
            MaterialManageView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store.debug)
        .frame(width: 900, height: 500)
}
