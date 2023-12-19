//
//  ModelViewCoordinator.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/16.
//

import MetalKit

class ModelViewCoordinator: NSObject {
    
    private let view: MVCView
    weak var controller: GraphicController?
    
    private var initialZoomValue: Float = 0.0
    
    init(view: MVCView, controller: GraphicController?) {
        self.view = view
        self.controller = controller
    }
    
    @objc
    func handleClick(_ recognizer: NSClickGestureRecognizer) {
        traceSnap()
    }
    
    @objc
    func handleLeftDrag(_ recognizer: NSPanGestureRecognizer) {
        guard let controller = controller else { return }
        
        let location = float2(recognizer.location(in: view))
        let translation = float2(recognizer.translation(in: view))
        let startLocation = location - translation
        
        // TODO: internal
        switch recognizer.state {
            case .began:
                controller.renderer.inputs.dragStartLocation.x = startLocation.x
                controller.renderer.inputs.dragStartLocation.y = Float(view.frame.height) - startLocation.y
            case .changed:
                controller.renderer.inputs.dragLocation.x = location.x
                controller.renderer.inputs.dragLocation.y = Float(view.frame.height) - location.y
                controller.renderer.inputs.mode = (startLocation.x < location.x) ? 1 : 2
            case .ended:
                controller.renderer.inputs.mode = 0
                traceSelection()
            default:
                break
        }
    }
    
    @objc
    func handleRightDrag(_ recognizer: NSPanGestureRecognizer) {
        guard let controller = controller else { return }
        
        let velocity = recognizer.velocity(in: view)
        
        if NSEvent.modifierFlags.contains(.shift) {
            controller.scene.camera.pan(float2(x: Float(velocity.x) * 0.00002,
                                                y: Float(velocity.y) * 0.00002))
        } else {
            controller.scene.camera.rotate(float2(x: -Float(velocity.x) * 0.0001,
                                                   y: -Float(velocity.y) * 0.0001))
        }
    }
    
    @objc
    func handleTrackPadPinch(_ recognizer: NSMagnificationGestureRecognizer) {
        guard let controller = controller else { return }
        
        switch recognizer.state {
            case .began:
                initialZoomValue = controller.scene.camera.viewSize
            case .changed:
                let magnification = Float(recognizer.magnification) 
                * controller.scene.camera.viewSize
                * Config.cameraControllSensitivity.zoom
                controller.scene.camera.viewSize = initialZoomValue - magnification
            case .ended:
                initialZoomValue = 0.0
            default:
                return
        }
    }
    
    func handleScrollWheel(with event: NSEvent) {
        guard let controller = controller else { return }
        
        let sizedScroll = Float(event.deltaY) * controller.scene.camera.viewSize
        controller.scene.camera.zoom(sizedScroll * Config.cameraControllSensitivity.zoom * 0.05)
    }
    
    func handleTrackPadScroll(with event: NSEvent) {
        guard let controller = controller else { return }
        
        if NSEvent.modifierFlags.contains(.shift) {
            controller.scene.camera.pan(float2(x: Float(event.deltaX) * 0.005,
                                                y: -Float(event.deltaY) * 0.005))
        } else {
            controller.scene.camera.rotate(float2(x: Float(event.deltaX) * 0.015,
                                                  y: -Float(event.deltaY) * 0.015))
        }

    }
    
    func handleKeyDown(with event: NSEvent) {}
    
    func handleKeyUp(with event: NSEvent) {}
    
    func traceSelection() {}
    
    func traceSnap() {}
}
