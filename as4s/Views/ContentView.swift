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
            ZStack {
                MVCView(controller: store.controller)
                    .onAppear {
                        addCoordinate(scene: store.scene)
                        constants(scene: store.scene)
                        addSelectionReactangle(scene: store.scene)
                    }
                Gesture(store: store)
            }
        }
    }
    
    private var addPoint: some View {
        Button("Add Point") { Actions.addPoint(store: store) }
    }
    
    private func addCoordinate(scene: MVCScene) {
        scene.rootNode.addChildNode(MVCNode(geometry: MVCLineGeometry.x))
        scene.rootNode.addChildNode(MVCNode(geometry: MVCLineGeometry.y))
        scene.rootNode.addChildNode(MVCNode(geometry: MVCLineGeometry.z))
    }
    
    private func constants(scene: MVCScene) {
        var a = MVCPointGeometry(position: .init(x: 0.5, y: 0, z: 0), color: .init(x: 1, y: 0, z: 0))
        a.isConstant = true
        scene.rootNode.addChildNode(MVCNode(geometry: a))
    }
    
    private func addSelectionReactangle(scene: MVCScene) {
        scene.rootNode.addChildNode(MVCNode(geometry: MVCThickPolylineGeometry.test))
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
