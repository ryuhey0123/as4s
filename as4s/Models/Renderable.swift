//
//  Renderable.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/13.
//

import SwiftUI
import Mevic

protocol Renderable {
    
    associatedtype Geometry: MVCGeometry
    associatedtype ElementConfig: AS4ElementConfig
    
    var geometry: Geometry! { get set }
    
    var geometryTag: UInt32! { get set }
    
    var labelGeometry: MVCLabelGeometry! { get set }
    
    var color: Color { get set }
    
    var isSelected: Bool { get set }
    
    func geometrySetup(model: Model)
}

extension Renderable {
    
    static func buildLabelGeometry(position: float3, tag: String) -> MVCLabelGeometry {
        MVCLabelGeometry(target: position, text: tag,
                         forgroundColor: .init(ElementConfig.labelColor),
                         backgroundColor: .init(Config.system.backGroundColor),
                         margin: .init(0, 8), alignment: .bottom)
    }
}
