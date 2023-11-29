//
//  GraphicController.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/28.
//
//

import SwiftUI
import Mevic

class GraphicController: MVCGraphicController {
    
    override func handleScroll() {
        let sizedScroll = inputController.mouseScroll
        scene.camera.zoom(sizedScroll.y * AS4Config.cameraControllSensitivity.zoom * 0.05)
    }
    
    override func handleRightDrag(_ gestureRecognize: NSPanGestureRecognizer) {
        let translation = gestureRecognize.translation(in: metalView)
        
        if inputController.keysPressed.contains(.leftShift) {
            panCamera(translation: translation, in: metalView!)
        } else {
            rotateCamera(translation: translation, in: metalView!)
        }
        
        gestureRecognize.setTranslation(.zero, in: metalView)
    }
    
    private func panCamera(translation: NSPoint, in view: NSView) {
        var translation = float2(translation) * AS4Config.cameraControllSensitivity.pan
        translation.x /= Float(view.frame.size.width) / 2
        translation.y /= Float(view.frame.size.height) / 2
        scene.camera.pan(translation)
    }
    
    private func rotateCamera(translation: NSPoint, in view: NSView) {
        var translation = float2(translation) * AS4Config.cameraControllSensitivity.rotate
        translation.x /= Float(view.frame.size.width) / (2 * .pi)
        translation.y /= Float(view.frame.size.height) / (2 * .pi)
        scene.camera.rotate(translation)
    }
    
    private func zoomCamera( delta: CGFloat) {
        let delta = Float(delta) * 0.05 * AS4Config.cameraControllSensitivity.zoom
        scene.camera.zoom(delta)
    }
}
