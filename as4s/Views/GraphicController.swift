//
//  GraphicController.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/28.
//
//

import Mevic

class GraphicController: MVCGraphicController {
    
    override func mouseScroll() {
        let sizedScroll = inputController.mouseScroll
        scene.camera.zoom(sizedScroll.y * AS4Config.cameraControllSensitivity.zoom * 0.05)
    }
}
