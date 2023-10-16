//
//  GestureView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

struct Gesture: NSViewRepresentable {
    let view = GestureView()
    let store: Store
    
    func makeNSView(context: Context) -> GestureView {
        view.store = store
        
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
    
    func updateNSView(_ nsView: GestureView, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(store: store, view: view)
    }
    
    class Coordinator: NSObject {
        private let view: NSView
        private let store: Store
        
        init(store: Store, view: NSView) {
            self.store = store
            self.view = view
        }
        
        @objc func handleClick(_ gestureRecognize: NSClickGestureRecognizer) {
            let point = gestureRecognize.location(in: view)
            Actions.tapOrClick(store: store, point: point)
        }
        
        @objc func handleLeftDrag(_ gestureRecognize: NSPanGestureRecognizer) {
            let translation = gestureRecognize.translation(in: view)
            Actions.leftDrag(store: store, translation: translation, in: view, state: gestureRecognize.state)
        }
        
        @objc func handleRightDrag(_ gestureRecognize: NSPanGestureRecognizer) {
            let translation = gestureRecognize.translation(in: view)
            Actions.rightDrag(store: store, translation: translation, in: view)
            // 加速度を削除するために逐一0とする
            gestureRecognize.setTranslation(.zero, in: view)
        }
    }
}


// MARK: - NSEvents

class GestureView : NSView {
    var store: Store?
    
    override func scrollWheel(with event: NSEvent) {
        Actions.scrollWheel(store: store!, delta: event.deltaY)
    }
}
