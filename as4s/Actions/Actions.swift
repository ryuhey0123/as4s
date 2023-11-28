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
        if let clickPoint = store.scene.getSnapedId() {
            Logger.action.trace("Click - Point:\(clickPoint)")
        }
    }
    
    static func leftDrag(store: Store, location: NSPoint, in view: NSView, state: NSGestureRecognizer.State) {
        let point: NSPoint = .init(x: location.x * 2, y: location.y * 2)
        
        switch state {
            case .began:
                beganSelectionRectangle(store: store, at: point)
            case .changed:
                resizeSelectionRectangle(store: store, at: point)
            case .ended:
                endSelectionRectangle(store: store, at: point)
            default:
                return
        }
    }
    
    static func rightDrag(store: Store, translation: NSPoint, in view: NSView) {
        if NSEvent.modifierFlags.contains(.shift) {
            Self.panCamera(store: store, translation: translation, in: view)
        } else {
            Self.rotateCamera(store: store, translation: translation, in: view)
        }
    }
    
    static func scrollWheel(store: Store, delta: CGFloat) {
        Self.zoomCamera(store: store, delta: delta)
    }
    
    static func mouseMoving(store: Store, location: NSPoint) {
        let point: NSPoint = .init(x: location.x * 2, y: location.y * 2)
        
        Self.snapToNode(store: store, location: point)
    }
    
    
    // MARK: - Geometry Controll
    
    static func addNode(at position: double3, store: Store) {
        let id = store.model.nodes.count + 1
        let node = AS4Node(id: id, position: position)
        store.model.append(node, layer: store.modelLayer!, overlayLayer: store.nodeLabel!)

        Logger.action.trace("Add Point - \(node.position.debugDescription)")
    }


    // MARK: - Other Geometry

    static func addCoordinate(store: Store) {
        store.captionLayer?.append(geometry: MVCLineGeometry.x)
        store.captionLayer?.append(geometry: MVCLineGeometry.y)
        store.captionLayer?.append(geometry: MVCLineGeometry.z)

        Logger.action.trace("Add Coordinate")
    }

    
    // MARK: - Selection Controll
    
    static func beganSelectionRectangle(store: Store, at point: NSPoint) {}
    
    static func resizeSelectionRectangle(store: Store, at point: NSPoint) {}
    
    static func endSelectionRectangle(store: Store, at point: NSPoint) {}
    
    static func snapToNode(store: Store, location: NSPoint) {}
    
    
    // MARK: - Camera Controll
    
    private static func panCamera(store: Store, translation: NSPoint, in view: NSView) {
        var translation = float2(translation) * AS4Config.cameraControllSensitivity.pan
        translation.x /= Float(view.frame.size.width) / 2
        translation.y /= Float(view.frame.size.height) / 2
        store.controller.scene.camera.pan(translation)
    }
    
    private static func rotateCamera(store: Store, translation: NSPoint, in view: NSView) {
        var translation = float2(translation) * AS4Config.cameraControllSensitivity.rotate
        translation.x /= Float(view.frame.size.width) / (2 * .pi)
        translation.y /= Float(view.frame.size.height) / (2 * .pi)
        store.controller.scene.camera.rotate(translation)
    }
    
    private static func zoomCamera(store: Store, delta: CGFloat) {
        let delta = Float(delta) * 0.05 * AS4Config.cameraControllSensitivity.zoom
        store.controller.scene.camera.zoom(delta)
    }
}
