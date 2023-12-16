//
//  GraphicScene.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import Mevic

class GraphicScene: MVCScene {
    override init(_ label: String? = nil) {
        super.init()
        
        camera.viewSize = 5000
        camera.near = 100_000
        camera.far = -100_000
    }
}
