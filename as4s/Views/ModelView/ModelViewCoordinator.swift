//
//  ModelViewCoordinator.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/16.
//

import MetalKit

class ModelViewCoordinator: NSObject {
    
    private let view: MVCView
    weak var controller: GraphicController!
    weak var store: Store!
    
    private var initialZoomValue: Float = 1.0
    
    init(view: MVCView) {
        self.view = view
    }
    
    @objc
    func handleRightDrag(_ gestureRecognize: NSPanGestureRecognizer) {
        let velocity = gestureRecognize.velocity(in: view)
        
        if NSEvent.modifierFlags.contains(.shift) {
            controller?.scene.camera.pan(float2(x: Float(velocity.x) * 0.00002,
                                                y: -Float(velocity.y) * 0.00002))
        } else {
            controller?.scene.camera.rotate(float2(x:  Float(velocity.x) * 0.0001,
                                                   y: -Float(velocity.y) * 0.0001))
        }
    }
    
    // FIXME: Zoom upしていくと挙動がおかしい
    @objc
    func handleTrackPadPinch(_ recognizer: NSMagnificationGestureRecognizer) {
        switch recognizer.state {
            case .began:
                initialZoomValue = controller.scene.camera.zoomValue
            case .changed:
                let sizedScroll = Float(recognizer.magnification) * Config.cameraControllSensitivity.zoom
                let newValue = max(0.0001, initialZoomValue + sizedScroll)
                controller.scene.camera.zoomValue = newValue
            default:
                return
        }
    }
    
    // FIXME: Zoom upしていくと挙動がおかしい
    func handleScrollWheel(with event: NSEvent) {
        if NSEvent.modifierFlags.contains(.shift) {
            let sizedScroll = Float(event.deltaY) * 0.05 * Config.cameraControllSensitivity.zoom
            controller.scene.camera.zoom(sizedScroll)
        } else if NSEvent.modifierFlags.contains(.control) {
            let sizedDelta = float2(event.deltaX, event.deltaY) * 0.01 * Config.cameraControllSensitivity.pan
            controller.scene.camera.pan(sizedDelta)
        } else {
            let sizedDelta = float2(event.deltaX, event.deltaY) * 0.01 * Config.cameraControllSensitivity.rotate
            controller.scene.camera.rotate(sizedDelta)
        }
    }
    
    func handleMouseDown(with event: NSEvent) {
        controller.dragStartLocation = float2(event.locationInWindow, at: view)
    }
    
    func handleMouseUp(with event: NSEvent) {
        Actions.select(store: store)
        controller.selectionMode = 0
    }
    
    func handleMouseMoved(with event: NSEvent) {
        controller.currentMouseLocation = float2(event.locationInWindow, at: view)
    }
    
    func handleMouseDragged(with event: NSEvent) {
        controller.currentMouseLocation = float2(event.locationInWindow, at: view)
        
        if controller.currentMouseLocation.x > controller.dragStartLocation.x {
            controller.selectionMode = 1
        } else {
            controller.selectionMode = 2
        }
    }
}
