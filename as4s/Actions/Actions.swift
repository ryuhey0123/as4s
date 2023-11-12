//
//  Actions.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

enum Actions {
    
    // MARK: - Gesture Handling
    
    static func tapOrClick(store: Store, point: NSPoint) {
        AS4Logger.logAction("Tap or Click - Point:\(point.debugDescription)")
        
        // exsample
        let modelPoint = store.controller.renderer.unprojectPoint(.init(x: Float(point.x), y: Float(point.y), z: 0))
        Actions.addPoint(at: double3(modelPoint), store: store)
    }
    
    static func leftDrag(store: Store, translation: NSPoint, in view: NSView, state: NSGestureRecognizer.State) {
        switch state {
            case .began:
                initSelectionRectangle(store: store, at: translation)
            case .changed:
                resizeSelectionRectangle(store: store, at: translation)
            case .ended:
                resetSelectionRectangle(store: store)
            default:
                return
        }
    }
    
    static func rightDrag(store: Store, translation: NSPoint, in view: NSView) {
        AS4Logger.logAction("Right Drag - Translation:\(translation.debugDescription)")
        
        if NSEvent.modifierFlags.contains(.shift) {
            Self.panCamera(store: store, translation: translation, in: view)
        } else {
            Self.rotateCamera(store: store, translation: translation, in: view)
        }
    }
    
    static func scrollWheel(store: Store, delta: CGFloat) {
        AS4Logger.logAction("Scroll Wheel - Delta:\(delta.description)")
        Self.zoomCamera(store: store, delta: delta)
    }
    
    
    // MARK: - Geometry Controll
    
    static func addPoint(store: Store) {
        let position: double3 = .random(in: -1...1)
        addPoint(at: position, store: store)
    }
    
    static func addPoint(at position: double3, store: Store) {
        let geom = MVCPointGeometry(position: float3(position), color: .init(x: 1, y: 0, z: 0))
        let node = MVCNode(geometry: geom)
        store.scene.rootNode.addChildNode(node)
        
        let label = MVCLabelNode(String(geom.id), target: float3(position))
        label.fontName = "Arial"
        store.overlayScene.addChild(label)
        
        let point = AS4Point(at: position)
        store.model.points.append(point)
        
        AS4Logger.logAction("Add Point - \(point.position.debugDescription)")
    }
    
    
    // MARK: - Selection Controll
    
    static func initSelectionRectangle(store: Store, at point: NSPoint) {
//        store.overlayScene.selectionRectangle.leftTop = point
        
        AS4Logger.logAction("Selection Began - \(point.debugDescription)")
    }
    
    static func resizeSelectionRectangle(store: Store, at point: NSPoint) {
//        store.overlayScene.selectionRectangle.rightBottom?.x += point.x
//        store.overlayScene.selectionRectangle.rightBottom?.y += point.y
        
        AS4Logger.logAction("Selection Change - \(point.debugDescription)")
    }
    
    static func resetSelectionRectangle(store: Store) {
//        store.overlayScene.selectionRectangle.reset()
        
        AS4Logger.logAction("Selection Ended")
    }
    
    
    // MARK: - Camera Controll
    
    private static func panCamera(store: Store, translation: NSPoint, in view: NSView) {
        var translation = float2(translation)
        translation.x /= Float(view.frame.size.width) / 2
        translation.y /= Float(view.frame.size.height) / 2
        store.controller.scene.camera.pan(translation)
        
        AS4Logger.logAction("Update camera: \(store.controller.scene.camera.transform)")
    }
    
    private static func rotateCamera(store: Store, translation: NSPoint, in view: NSView) {
        var translation = float2(translation)
        translation.x /= Float(view.frame.size.width) / (2 * .pi)
        translation.y /= Float(view.frame.size.height) / (2 * .pi)
        store.controller.scene.camera.rotate(translation)
        
        AS4Logger.logAction("Update camera: \(store.controller.scene.camera.transform)")
    }
    
    private static func zoomCamera(store: Store, delta: CGFloat) {
        var delta = Float(delta)
        delta *= 0.05
        store.controller.scene.camera.zoom(delta)
        
        AS4Logger.logAction("Update camera: \(store.controller.scene.camera.transform)")
    }
}
