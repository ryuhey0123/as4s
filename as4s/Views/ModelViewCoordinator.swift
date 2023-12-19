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
    func handleClick(_ recognizer: NSClickGestureRecognizer) {
        traceSnap()
    }
    
    @objc
    func handleLeftDrag(_ recognizer: NSPanGestureRecognizer) {
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
    
    func handleKeyDown(with event: NSEvent) {}
    
    func handleKeyUp(with event: NSEvent) {}
    
    func traceSelection() {
        let selectionIds = controller.renderer.getSeletionId()
        
        if !selectionIds.isEmpty {
            let selectedNodes = store.model.nodes.filter({
                selectionIds.contains(Int($0.geometry.model.id))
            })
            selectedNodes.forEach { $0.isSelected = true }
            
            let selectedBeam = store.model.beams.filter({
                selectionIds.contains(Int($0.geometry.model.id))
            })
            selectedBeam.forEach { $0.isSelected = true }
        }
    }
    
    func traceSnap() {}
}
