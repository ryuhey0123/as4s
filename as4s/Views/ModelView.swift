//
//  ModelView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/15.
//

import SwiftUI
import MetalKit

public struct ModelView: View {
    
    var store: Store
    
    @State private var metalView = MVCView()
    @State private var controller: GraphicController?
    
    public var body: some View {
        MetalViewRepresentable(view: $metalView, controller: controller, store: store)
            .onAppear {
                controller = GraphicController(metalView: metalView, scene: store.scene)
            }
    }
}

#if os(macOS)
private typealias ViewRepresentable = NSViewRepresentable
#elseif os(iOS)
private typealias ViewRepresentable = UIViewRepresentable
#endif

private struct MetalViewRepresentable: ViewRepresentable {
    @Binding var view: MVCView
    let controller: GraphicController?
    let store: Store?
    
#if os(macOS)
    func makeNSView(context: Context) -> some NSView {
        let clickGesture = NSClickGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleClick(_:)))
        view.addGestureRecognizer(clickGesture)
        
        let leftDragGesture = NSPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleLeftDrag(_:)))
        leftDragGesture.buttonMask = 0x1  // Left button
        view.addGestureRecognizer(leftDragGesture)
        
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
    
    override func scrollWheel(with event: NSEvent) {
        if event.hasPreciseScrollingDeltas {
            coordinator?.handleTrackPadScroll(with: event)
        } else {
            coordinator?.handleScrollWheel(with: event)
        }
    }
    
    override func keyDown(with event: NSEvent) {
        super.keyDown(with: event)
        coordinator?.handleKeyDown(with: event)
    }
    
    override func keyUp(with event: NSEvent) {
        super.keyUp(with: event)
        coordinator?.handleKeyUp(with: event)
    }
}
