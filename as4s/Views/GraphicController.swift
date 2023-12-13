//
//  GraphicController.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/28.
//

import SwiftUI
import GameController

import Mevic

class GraphicController: MVCGraphicController {
    
    weak var store: Store?
    
    private var lastSelectedNode: Node?
    
    // MARK: init
    
    override init(scene: MVCScene) {
        super.init(scene: scene)
        
        lineGideGeometry.iColor = float4(float3(Config.drawingGide.lineColor), 1)
        lineGideGeometry.jColor = float4(float3(Config.drawingGide.lineColor), 1)
        
        scene.camera.viewSize = 5000
        scene.camera.near = -100_000
        scene.camera.far = 100_000
    }
    
    
    // MARK: Handlers
    
    override func handleClick(_ gestureRecognize: NSClickGestureRecognizer) {
        if let snapedId = scene.getSnapedId() {
            guard let node = store?.model.nodes.first(where: { $0.geometryTag == snapedId }) else { return }
            
            if isDrawingLine {
                guard let lastSelectedNode = lastSelectedNode else { return }
                let id = store!.model.beams.count + 1
                Actions.addBeam(id: id, i: lastSelectedNode, j: node, store: store!)
                lineGideGeometry.j = lineGideGeometry.i
                isDrawingLine.toggle()
            } else {
                lineGideGeometry.i = float3(node.position)
                lastSelectedNode = node
                isDrawingLine.toggle()
            }
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
        let sizedScroll = inputController.mouseScroll * scene.camera.viewSize
        scene.camera.zoom(sizedScroll.y * Config.cameraControllSensitivity.zoom * 0.05)
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
            let selectedNodes: [Node] = store!.model.nodes.filter( { selectionId.contains(Int($0.geometryTag)) })
            let selectedElems: [Beam] = store!.model.beams.filter( { selectionId.contains(Int($0.geometryTag)) })
            
            if inputController.keysPressed.isEmpty {
                selectedNodes.forEach { $0.isSelected = true }
                for element in selectedElems { element.isSelected = true }
                Logger.action.trace("\(#function): Add selected nodes \(selectedNodes.map { $0.nodeTag })")
                Logger.action.trace("\(#function): Add selected beams \(selectedElems.map { $0.eleTag })")
                
            } else if inputController.keysPressed.contains(.leftShift) {
                selectedNodes.forEach { $0.isSelected = false }
                for element in selectedElems { element.isSelected = false }
                Logger.action.trace("\(#function): Remove selected nodes \(selectedNodes.map { $0.nodeTag })")
                Logger.action.trace("\(#function): Remove selected beams \(selectedElems.map { $0.eleTag })")
            }
        }
    }
    
    private func panCamera(translation: NSPoint, in view: NSView) {
        var translation = float2(translation) * Config.cameraControllSensitivity.pan
        translation.x /= Float(view.frame.size.width) / 2
        translation.y /= Float(view.frame.size.height) / 2
        scene.camera.pan(translation)
    }
    
    private func rotateCamera(translation: NSPoint, in view: NSView) {
        var translation = float2(translation) * Config.cameraControllSensitivity.rotate
        translation.x /= Float(view.frame.size.width) / (2 * .pi)
        translation.y /= Float(view.frame.size.height) / (2 * .pi)
        scene.camera.rotate(translation)
    }
    
    private func zoomCamera( delta: CGFloat) {
        let delta = Float(delta) * 0.05 * Config.cameraControllSensitivity.zoom
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
