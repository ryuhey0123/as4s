//
//  TableView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct TableView: View {
    @ObservedObject var store: Store
    
    @State private var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NodeTable(nodes: $store.model.nodes)
                .tabItem { Text("Node") }.tag(1)
            BeamColumnTable(beams: $store.model.beams)
                .tabItem { Text("Beam") }.tag(2)
            MaterialTable(materials: $store.model.materials)
                .tabItem { Text("Material") }.tag(3)
        }
        .padding()
    }
}

#Preview {
    TableView(store: Store.debug)
}
