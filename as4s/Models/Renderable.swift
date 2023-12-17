//
//  Renderable.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/13.
//

protocol Renderable {
    
    func appendTo(model: Model)
    
    func appendTo(scene: GraphicScene)
}
