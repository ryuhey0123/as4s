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
        let clickGesture = NSClickGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleClick(_:)))
        view.addGestureRecognizer(clickGesture)
        
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
            let modelPoint = store.controller.renderer.unprojectPoint(.init(x: Float(point.x), y: Float(point.y), z: 0))
            Actions.addPoint(at: double3(modelPoint), store: store)
        }
    }
}


// MARK: - NSEvents

class GestureView : NSView {

}
