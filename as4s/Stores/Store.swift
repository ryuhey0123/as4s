//
//  Store.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

final class Store {
    var model: AS4Model
    
    let scene: MVCScene = MVCScene()
    let overlayScene = MVCOverlayScene()
    
    var modelLayer: MVCLayer?
    var captionLayer: MVCLayer?
    
    var nodeLabel: MVCOverlayLayer?
    
    var selectionBox = MVCSelectionBoxNode()
    var cursor = MVCCursorNode()
    
    let controller: MVCGraphicController
    
    init() {
        model = AS4Model()
        controller = MVCGraphicController(scene: scene, overlayScene: overlayScene)
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        model = try JSONDecoder().decode(AS4Model.self, from: data)
        controller = MVCGraphicController(scene: scene, overlayScene: overlayScene)
    }

    func updateView() {
        modelLayer = MVCLayer("Model")
        captionLayer = MVCLayer("Caption")
        scene.append(layer: modelLayer!)
        scene.append(layer: captionLayer!)
        
        nodeLabel = MVCOverlayLayer("Node")
        overlayScene.append(layer: nodeLabel!)
        
        selectionBox.fillColor = NSColor(AS4Config.selectionBox.fillColor)
        selectionBox.strokeColor = NSColor(AS4Config.selectionBox.strokeColor)
        overlayScene.addChild(selectionBox)
        
        cursor.size = AS4Config.cursor.size
        cursor.lineWidth = AS4Config.cursor.lineWidth
        overlayScene.addChild(cursor)
    }
}

class SharedStore: ObservableObject {
    var stores: [Store] = []
}
