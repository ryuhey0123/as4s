//
//  GraphicController.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/28.
//
//

import SwiftUI
import GameController

import Mevic

class GraphicController: MVCGraphicController {
    
    weak var store: Store?
    
    
    // MARK: init
    
    override init(scene: MVCScene) {
        super.init(scene: scene)
        
        lineGideGeometry.iColor = float4(float3(AS4Config.drawingGide.lineColor), 1)
        lineGideGeometry.jColor = float4(float3(AS4Config.drawingGide.lineColor), 1)
    }
    
    
    // MARK: Handlers
    
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
    
    override func keysPressed(_ keys: Set<GCKeyCode>) {
        if keys.contains(.escape) {
            cancelDrawing()
            cancelSelecting()
        }
    }
    
    
    // MARK: Utilities
    
    override func traceSelection() {
        let selectionId = scene.getSeletionId()
        if !selectionId.isEmpty {
            let selectedNodes: [AS4Node] = store!.model.nodes.filter( { selectionId.contains(Int($0.geometryId)) })
            let selectedBeams: [AS4Beam] = store!.model.beams.filter( { selectionId.contains(Int($0.geometryId)) })
            
            if inputController.keysPressed.isEmpty {
                selectedNodes.forEach { $0.isSelected = true }
                selectedBeams.forEach { $0.isSelected = true }
                Logger.action.trace("\(#function): Add selected nodes \(selectedNodes.map { $0.id })")
                Logger.action.trace("\(#function): Add selected beams \(selectedBeams.map { $0.id })")
                
            } else if inputController.keysPressed.contains(.leftShift) {
                selectedNodes.forEach { $0.isSelected = false }
                selectedBeams.forEach { $0.isSelected = false }
                Logger.action.trace("\(#function): Remove selected nodes \(selectedNodes.map { $0.id })")
                Logger.action.trace("\(#function): Remove selected beams \(selectedBeams.map { $0.id })")
            }
        }
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
    
    private func cancelDrawing() {
        isDrawingLine = false
        lineGideGeometry.j = lineGideGeometry.i
    }
    
    private func cancelSelecting() {
        store!.model.nodes.forEach { $0.isSelected = false }
        store!.model.beams.forEach { $0.isSelected = false }
    }
}
