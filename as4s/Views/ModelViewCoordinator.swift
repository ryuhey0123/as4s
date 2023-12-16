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
    
    init(view: MVCView, controller: GraphicController?) {
        self.view = view
        self.controller = controller
    }
    
    @objc
    func handleClick(_ gestureRecognize: NSClickGestureRecognizer) {
        traceSnap()
    }
    
    @objc
    func handleLeftDrag(_ gestureRecognize: NSPanGestureRecognizer) {
        let location = float2(gestureRecognize.location(in: view))
        let translation = float2(gestureRecognize.translation(in: view))
        let startLocation = location - translation
        
        // TODO: internal
        switch gestureRecognize.state {
            case .began:
                controller?.renderer.inputs.dragStartLocation.x = startLocation.x
                controller?.renderer.inputs.dragStartLocation.y = Float(view.frame.height) - startLocation.y
            case .changed:
                controller?.renderer.inputs.dragLocation.x = location.x
                controller?.renderer.inputs.dragLocation.y = Float(view.frame.height) - location.y
                controller?.renderer.inputs.mode = (startLocation.x < location.x) ? 1 : 2
            case .ended:
                controller?.renderer.inputs.mode = 0
                traceSelection()
            default:
                break
        }
    }
    
    @objc
    func handleRightDrag(_ gestureRecognize: NSPanGestureRecognizer) {
        let velocity = gestureRecognize.velocity(in: view)
        
        if NSEvent.modifierFlags.contains(.shift) {
            controller?.scene.camera.pan(float2(x: Float(velocity.x) * 0.00002,
                                                y: Float(velocity.y) * 0.00002))
        } else {
            controller?.scene.camera.rotate(float2(x: -Float(velocity.x) * 0.0001,
                                                   y: -Float(velocity.y) * 0.0001))
        }
    }
    
    func handleScrollWheel(with event: NSEvent) {
        controller?.scene.camera.zoom(Float(event.deltaY) * 10)
    }
    
    func handleKeyDown(with event: NSEvent) {}
    
    func handleKeyUp(with event: NSEvent) {}
    
    func traceSelection() {}
    
    func traceSnap() {}
}
