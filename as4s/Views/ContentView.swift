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
    
    var body: some View {
        NavigationSplitView {
            Sidebar()
        } detail: {
            ModelView(scene: store.scene)
                .onAppear {
                    Actions.addCoordinate(store: store)
                }
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
        .frame(width: 800, height: 500)
}
