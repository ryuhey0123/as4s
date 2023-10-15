//
//  ContentView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

struct ContentView: View {
    @Binding var document: as4sDocument
    
    let scene = MVCScene()
    let overlayScene = MVCOverlayScene()

    var body: some View {
        NavigationSplitView {
            addPoint
        } detail: {
            MVCView(scene: scene, overlayScene: overlayScene)
        }
    }
    
    private var addPoint: some View {
        Button("Add Point") {
            let position: float3 = .random(in: -1...1)
            
            let geom = MVCPointGeometry(position: position, color: .init(x: 1, y: 0, z: 0))
            let node = MVCNode(geometry: geom)
            scene.rootNode.addChildNode(node)
            
            let label = MOSLabelNode("Test", target: position)
            label.fontName = "Arial"
            overlayScene.addChild(label)
            
            
            // FIXME: BindingでsceneやoverlaySceneが別物になっているのでは
            document.model.positions.append(position)
        }
    }
}

#Preview {
    ContentView(document: .constant(as4sDocument()))
}
