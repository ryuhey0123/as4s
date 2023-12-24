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
    
    var body: some View {
        GeometryReader { geometry in
            NavigationSplitView {
                Sidebar()
                    .frame(minWidth: 170)
                    .toolbar {
                        ToolbarItemGroup {
                            startPauseButton
                        }
                    }
            } detail: {
                Detail()
                    .toolbar {
                        ToolbarItemGroup(placement: .principal) {
                            ProgressBar(title: $store.progressTitle, subtitle: $store.progressSubtitle, progress: $store.progress, total: $store.progressEstimated)
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
            }
        }
        .inspector(isPresented: $showingInspector) {
            ObjectInspector(selectedObjects: $store.selectedObjects)
        }
        .onExitCommand(perform: {
            Actions.unselectAll(store: store)
        })
        .focusedSceneValue(\.showTransform, $showingTransform)
        .sheet(isPresented: $showingTransform) {
            TransformView()
        }
    }
    
    private var startPauseButton: some View {
        Button {
            
        } label: {
            Image(systemName: "play.fill")
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store.debug)
        .frame(width: 900, height: 500)
}
