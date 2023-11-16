//
//  Actions.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import SpriteKit
import Mevic

enum Actions {
    
    // MARK: - Gesture Handling
    
    static func tapOrClick(store: Store, point: NSPoint) {
        AS4Logger.logAction("Tap or Click - Point:\(point.debugDescription)")
        
        let modelPoint = store.controller.renderer.unprojectPoint(.init(x: Float(point.x), y: Float(point.y), z: 0))
        Actions.addNode(at: double3(modelPoint), store: store)
    }
    
    static func leftDrag(store: Store, translation: NSPoint, in view: NSView, state: NSGestureRecognizer.State) {
        switch state {
            case .began:
                beganSelectionRectangle(store: store, at: translation)
            case .changed:
                resizeSelectionRectangle(store: store, at: translation)
            case .ended:
                endSelectionRectangle(store: store)
            default:
                return
        }
    }
    
    static func rightDrag(store: Store, translation: NSPoint, in view: NSView) {
        // AS4Logger.logAction("Right Drag - Translation:\(translation.debugDescription)")

        if NSEvent.modifierFlags.contains(.shift) {
            Self.panCamera(store: store, translation: translation, in: view)
        } else {
            Self.rotateCamera(store: store, translation: translation, in: view)
        }
    }
    
    static func scrollWheel(store: Store, delta: CGFloat) {
        // AS4Logger.logAction("Scroll Wheel - Delta:\(delta.description)")
        Self.zoomCamera(store: store, delta: delta)
    }
    
    
    // MARK: - Geometry Controll
    
    static func addNode(at position: double3, store: Store) {
        let id = store.model.nodes.count + 1
        let node = AS4Node(id: id, position: position)
        store.model.append(node, layer: store.modelLayer!, overlayLayer: store.nodeLabel!)

        AS4Logger.logAction("Add Point - \(node.position.debugDescription)")
    }


    // MARK: - Other Geometry

    static func addCoordinate(store: Store) {
        store.captionLayer?.append(geometry: MVCLineGeometry.x)
        store.captionLayer?.append(geometry: MVCLineGeometry.y)
        store.captionLayer?.append(geometry: MVCLineGeometry.z)

        AS4Logger.logAction("Add Coordinate")
    }

    
    // MARK: - Selection Controll
    
    static func beganSelectionRectangle(store: Store, at point: NSPoint) {
//        store.selectionBox.run(SKAction.fadeIn(withDuration: 0.01))
        store.selectionBox.leftTop = point
        
        AS4Logger.logAction("Selection Began - \(point.debugDescription)")
    }
    
    static func resizeSelectionRectangle(store: Store, at point: NSPoint) {
//        store.selectionBox.isHidden = false
        store.selectionBox.rightBottom = point
        
        AS4Logger.logAction("Selection Change - \(point.debugDescription)")
    }
    
    static func endSelectionRectangle(store: Store) {
//        store.selectionBox.run(SKAction.fadeOut(withDuration: 0.2))
        store.selectionBox.removeRect()
        
        AS4Logger.logAction("Selection Ended")
    }
    
    
    // MARK: - Camera Controll
    
    private static func panCamera(store: Store, translation: NSPoint, in view: NSView) {
        var translation = float2(translation)
        translation.x /= Float(view.frame.size.width) / 2
        translation.y /= Float(view.frame.size.height) / 2
        store.controller.scene.camera.pan(translation)
        
        // AS4Logger.logAction("Update camera: \(store.controller.scene.camera.transform)")
    }
    
    private static func rotateCamera(store: Store, translation: NSPoint, in view: NSView) {
        var translation = float2(translation)
        translation.x /= Float(view.frame.size.width) / (2 * .pi)
        translation.y /= Float(view.frame.size.height) / (2 * .pi)
        store.controller.scene.camera.rotate(translation)
        
        // AS4Logger.logAction("Update camera: \(store.controller.scene.camera.transform)")
    }
    
    private static func zoomCamera(store: Store, delta: CGFloat) {
        var delta = Float(delta)
        delta *= 0.05
        store.controller.scene.camera.zoom(delta)
        
        // AS4Logger.logAction("Update camera: \(store.controller.scene.camera.transform)")
    }
}
