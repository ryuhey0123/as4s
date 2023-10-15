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
        } detail: {
            MVCView(scene: store.scene, overlayScene: store.overlayScene)
        }
    }
    
    private var addPoint: some View {
        Button("Add Point") {
            let position: float3 = .random(in: -1...1)
            
            let geom = MVCPointGeometry(position: position, color: .init(x: 1, y: 0, z: 0))
            let node = MVCNode(geometry: geom)
            store.scene.rootNode.addChildNode(node)
            
            let label = MOSLabelNode("Test", target: position)
            label.fontName = "Arial"
            store.overlayScene.addChild(label)
            
            store.model.points.append(.init(at: double3(position)))
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
