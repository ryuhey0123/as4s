//
//  DispNode.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/29.
//

import Mevic

final class DispNode {
    
    weak var node: Node!
    
    var disp: float3
    
    var geometry: NodeDispGeometry
    
    init(node: Node, disp: float3 = .zero) {
        self.node = node
        self.disp = disp
        self.geometry = NodeDispGeometry(position: node.position, disp: disp)
    }
}
