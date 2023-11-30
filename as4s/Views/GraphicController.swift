//
//  GraphicController.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/28.
//
//

import SwiftUI
import Mevic
import GameController

class GraphicController: MVCGraphicController {
    
    weak var store: Store?
    
    override init(scene: MVCScene) {
        super.init(scene: scene)
        
        lineGideGeometry.iColor = float4(float3(AS4Config.drawingGide.lineColor), 1)
        lineGideGeometry.jColor = float4(float3(AS4Config.drawingGide.lineColor), 1)
    }
    
    override func handleClick(_ gestureRecognize: NSClickGestureRecognizer) {
        if let snapedId = scene.getSnapedId() {
            guard let point = scene.layers.flatMap({ $0.geometries }).compactMap({ $0 as? MVCPointGeometry }).first(where: { $0.id == snapedId }) else { return }
            
            if isDrawingLine {
                Actions.addBeam(i: double3(lineGideGeometry.i), j: double3(point.position), store: store!)
                lineGideGeometry.j = lineGideGeometry.i
            } else {
                lineGideGeometry.i = point.position
            }
            
            isDrawingLine.toggle()
        }
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
    
    override func handleScroll() {
        let sizedScroll = inputController.mouseScroll
        scene.camera.zoom(sizedScroll.y * AS4Config.cameraControllSensitivity.zoom * 0.05)
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
