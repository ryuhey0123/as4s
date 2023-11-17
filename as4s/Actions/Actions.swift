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
        // FadeOutが終わらないうちにBeganした場合、残っているアクションを削除し初期化
        store.selectionBox.removeAllActions()
        store.selectionBox.removeRect()
        
        // FadeOutと逆のアクションをして表示。必要なのか？
        store.selectionBox.run(SKAction.fadeIn(withDuration: 0))
        
        store.selectionBox.p1 = point
        
        AS4Logger.logAction("Selection Began - \(point.debugDescription)")
    }
    
    static func resizeSelectionRectangle(store: Store, at point: NSPoint) {
        store.selectionBox.p2 = point
    }
    
    static func endSelectionRectangle(store: Store, at point: NSPoint) {
        store.selectionBox.run(SKAction.fadeOut(withDuration: 0.3))
        
        if let rect = store.selectionBox.rect {
            store.model.nodes.filter { $0.isContain(in: rect) }.forEach {
                $0.isSelected.toggle()
                AS4Logger.logAction("Selected - \($0.id.description)")
            }
        }
        
        AS4Logger.logAction("Selection Ended - \(point.debugDescription)")
    }
    
    static func snapToNode(store: Store, location: NSPoint) {
        let r = Config.cursor.snapRadius
        let snapNode = store.model.nodes.filter { $0.screenPoint.isClose(to: location, radius: r) }.first
        
        if let snapNode = snapNode {
            store.cursor.position = snapNode.screenPoint
        } else {
            store.cursor.position = location
        }
    }
    
    
    // MARK: - Camera Controll
    
    private static func panCamera(store: Store, translation: NSPoint, in view: NSView) {
        var translation = float2(translation) * Config.cameraControllSensitivity.pan
        translation.x /= Float(view.frame.size.width) / 2
        translation.y /= Float(view.frame.size.height) / 2
        store.controller.scene.camera.pan(translation)
    }
    
    private static func rotateCamera(store: Store, translation: NSPoint, in view: NSView) {
        var translation = float2(translation) * Config.cameraControllSensitivity.rotate
        translation.x /= Float(view.frame.size.width) / (2 * .pi)
        translation.y /= Float(view.frame.size.height) / (2 * .pi)
        store.controller.scene.camera.rotate(translation)
    }
    
    private static func zoomCamera(store: Store, delta: CGFloat) {
        let delta = Float(delta) * 0.05 * Config.cameraControllSensitivity.zoom
        store.controller.scene.camera.zoom(delta)
    }
}
