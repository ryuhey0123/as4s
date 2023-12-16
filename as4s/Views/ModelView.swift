//
//  ModelView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/15.
//

import SwiftUI
import MetalKit

public struct ModelView: View {
    
    var scene: GraphicScene
    
    @State private var metalView = MVCView()
    @State private var controller: GraphicController?
    
    public var body: some View {
        MetalViewRepresentable(view: $metalView, controller: controller)
            .onAppear {
                controller = GraphicController(metalView: metalView, scene: scene)
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
        
        return view
    }
    
    func updateNSView(_ uiView: NSViewType, context: Context) {
        context.coordinator.controller = controller
        view.coordinator = context.coordinator
    }
    
#elseif os(iOS)
    func makeUIView(context: Context) -> MTKView {
        return view
    }
    
    func updateUIView(_ uiView: MTKView, context: Context) {}
#endif
    
    func makeCoordinator() -> ModelViewCoordinator {
        ModelViewCoordinator(view: view, controller: controller)
    }
}

class MVCView: MTKView {
    weak var coordinator: ModelViewCoordinator?
    
    override var acceptsFirstResponder: Bool { true }
    
    override func scrollWheel(with event: NSEvent) {
        super.scrollWheel(with: event)
        coordinator?.handleScrollWheel(with: event)
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
