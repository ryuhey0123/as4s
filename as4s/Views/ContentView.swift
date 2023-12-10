//
//  ContentView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

struct ContentView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        NavigationSplitView {
            addPoint
            importBigTestModel
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
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
