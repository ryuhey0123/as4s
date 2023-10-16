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
                MVCView(controller: &store.controller)
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
        let xLine = MVCLineGeometry(
            positions: [.init(x: 0, y: 0, z: 0), .init(x: 1, y: 0, z: 0)],
            colors: [.init(x: 1, y: 0, z: 0), .init(x: 1, y: 0, z: 0)])
        let yLine = MVCLineGeometry(
            positions: [.init(x: 0, y: 0, z: 0), .init(x: 0, y: 1, z: 0)],
            colors: [.init(x: 0, y: 1, z: 0), .init(x: 0, y: 1, z: 0)])
        let zLine = MVCLineGeometry(
            positions: [.init(x: 0, y: 0, z: 0), .init(x: 0, y: 0, z: 1)],
            colors: [.init(x: 0, y: 0, z: 1), .init(x: 0, y: 0, z: 1)])
        scene.rootNode.addChildNode(MVCNode(geometry: xLine))
        scene.rootNode.addChildNode(MVCNode(geometry: yLine))
        scene.rootNode.addChildNode(MVCNode(geometry: zLine))
    }
    
    private func constants(scene: MVCScene) {
        var a = MVCPointGeometry(position: .init(x: 0.5, y: 0, z: 0), color: .init(x: 1, y: 0, z: 0))
        a.isConstant = true
        scene.rootNode.addChildNode(MVCNode(geometry: a))
    }
    
    private func addSelectionReactangle(scene: MVCScene) {
        let leftTop = float3(x: 0, y: 0.5, z: 0)
        let rightBottom = float3(x: 0.5, y: 0, z: 0)
        let color = float3(x: 1, y: 1, z: 0)
        
        var geometry = MVCPlaneGeometry(positions: [
            .init(x: leftTop.x, y: rightBottom.y, z: 0),
            .init(x: leftTop.x, y: leftTop.y, z: 0),
            .init(x: rightBottom.x, y: rightBottom.y, z: 0),
            .init(x: rightBottom.x, y: rightBottom.y, z: 0),
            .init(x: leftTop.x, y: leftTop.y, z: 0),
            .init(x: rightBottom.x, y: leftTop.y, z: 0)
        ], colors: [float3].init(repeating: color, count: 6))
        
        geometry.isConstant = true
        
        let node = MVCNode(geometry: geometry)
        
        scene.rootNode.addChildNode(node)
    }
}

#Preview {
    ContentView()
        .environmentObject(Store())
}
