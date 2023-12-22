//
//  MVCView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import MetalKit
import SwiftUI

#if os(macOS)
private typealias ViewRepresentable = NSViewRepresentable
#elseif os(iOS)
private typealias ViewRepresentable = UIViewRepresentable
#endif

struct MVCViewRepresentable: ViewRepresentable {
    @Binding var view: MVCView
    let controller: GraphicController?
    let store: Store?
    
#if os(macOS)
    func makeNSView(context: Context) -> some NSView {
        let rightDragGesture = NSPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleRightDrag(_:)))
        rightDragGesture.buttonMask = 0x2  // Right button
        view.addGestureRecognizer(rightDragGesture)
        
        let pinchGesture = NSMagnificationGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleTrackPadPinch(_:)))
        view.addGestureRecognizer(pinchGesture)
        
        return view
    }
    
    func updateNSView(_ uiView: NSViewType, context: Context) {
        context.coordinator.controller = controller
        context.coordinator.store = store
        view.coordinator = context.coordinator
    }
    
#elseif os(iOS)
    func makeUIView(context: Context) -> MTKView {
        return view
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {}
#endif
    
    func makeCoordinator() -> ModelViewCoordinator {
        ModelViewCoordinator(view: view)
    }
}

class MVCView: MTKView {
    weak var coordinator: ModelViewCoordinator?
    
    override var acceptsFirstResponder: Bool { true }
    
    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()
        updateTrackingAreas()
    }
    
    override func updateTrackingAreas() {
        super.updateTrackingAreas()
        
        if let existingTrackingArea = trackingAreas.first {
            self.removeTrackingArea(existingTrackingArea)
        }
        
        let options: NSTrackingArea.Options = [
            .activeAlways,
            .mouseMoved,
        ]
        let trackingArea = NSTrackingArea(rect: bounds, options: options, owner: self, userInfo: nil)
        addTrackingArea(trackingArea)
    }
    
    override func scrollWheel(with event: NSEvent) {
        super.scrollWheel(with: event)
        coordinator?.handleScrollWheel(with: event)
    }
    
    override func mouseDown(with event: NSEvent) {
        super.mouseDown(with: event)
        coordinator?.handleMouseDown(with: event)
    }
    
    override func mouseUp(with event: NSEvent) {
        super.mouseUp(with: event)
        coordinator?.handleMouseUp(with: event)
    }
    
    override func mouseMoved(with event: NSEvent) {
        super.mouseMoved(with: event)
        coordinator?.handleMouseMoved(with: event)
    }
    
    override func mouseDragged(with event: NSEvent) {
        super.mouseDragged(with: event)
        coordinator?.handleMouseDragged(with: event)
    }
}
