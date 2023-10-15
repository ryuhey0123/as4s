//
//  ContentView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import SpriteKit

struct ContentView: View {
    @Binding var document: as4sDocument
    
    let scene = MVCScene()
    let overlayScene = MVCOverlayScene()

    var body: some View {
        NavigationSplitView {
            Button("Add Point") {
                let position: float3 = .random(in: -1...1)
                let geom = MVCPointGeometry(position: position, color: .init(x: 1, y: 0, z: 0))
                let node = MVCNode(geometry: geom)
                scene.rootNode.addChildNode(node)
                
                let label = SKLabelNode(text: "Test")
                label.fontName = "Arial"
                overlayScene.labelNode.addChild(label)
                overlayScene.labelNodePositions.append(position)
            }
        } detail: {
            MVCView(scene: scene, overlayScene: overlayScene)
                .onAppear {
                    let position: float3 = .zero
                    let geom = MVCPointGeometry(position: position, color: .init(x: 1, y: 0, z: 0))
                    let node = MVCNode(geometry: geom)
                    scene.rootNode.addChildNode(node)
                    
                    let label = SKLabelNode(text: "Test")
                    label.fontName = "Arial"
                    overlayScene.labelNode.addChild(label)
                    overlayScene.labelNodePositions.append(position)
                }
        }
    }
}

#Preview {
    ContentView(document: .constant(as4sDocument()))
}
