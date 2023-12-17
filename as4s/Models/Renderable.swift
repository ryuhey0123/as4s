//
//  Renderable.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/13.
//

import SwiftUI
import Mevic

protocol Renderable {
    
    associatedtype ElementConfigType: ElementConfig
    
    func appendTo(model: Model)
    
    func appendTo(scene: GraphicScene)
}

extension Renderable {
    
    static func buildLabelGeometry(target: float3, tag: String) -> MVCLabelGeometry {
        MVCLabelGeometry(target: target,
                         text: tag,
                         forgroundColor: .init(ElementConfigType.labelColor),
                         backgroundColor: .init(ElementConfigType.labelBgColor),
                         margin: .init(ElementConfigType.labelPaddingX, ElementConfigType.labelPaddingY),
                         alignment: ElementConfigType.labelAlignment
        )
    }
}
