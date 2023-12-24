//
//  NodalLoad.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/07.
//

import Mevic
import OpenSeesCoder

class NodalLoad {
    
    var id: Int
    var node: Node
    var loadvalues: [Float]
    var geometry: NodalLoadGeometry!
    
    init(id: Int, node: Node, loadvalues: [Float]) {
        self.id = id
        self.node = node
        self.loadvalues = loadvalues
        self.geometry = NodalLoadGeometry(id: id, position: node.position, loadvalues: loadvalues)
        
        node.updateHandlers.append {
            self.geometry.updateNode(id: self.id, position: self.node.position)
        }
    }
}

extension NodalLoad: Renderable {
    
    func appendTo(model: Model) {
        model.nodalLoads.append(self)
    }
    
    func appendTo(scene: GraphicScene) {
        scene.loadLayer.nodal.append(geometry: geometry.model)
        scene.loadLayer.nodal.append(geometry: geometry.label)
    }
}

extension NodalLoad: OSNodalLoad {
    var nodeTag: Int { node.id }
}
