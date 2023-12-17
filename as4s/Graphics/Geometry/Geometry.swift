//
//  Geometry.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/17.
//

import Mevic

protocol Geometry {
    associatedtype ElementConfigType: ElementConfig
}

extension Geometry {
    static func defaultLabel(target: float3, tag: String = "0") -> MVCLabelGeometry {
        MVCLabelGeometry(target: target,
                         text: tag,
                         forgroundColor: .init(ElementConfigType.labelColor),
                         backgroundColor: .init(ElementConfigType.labelBgColor),
                         margin: .init(ElementConfigType.labelPaddingX, ElementConfigType.labelPaddingY),
                         alignment: ElementConfigType.labelAlignment
        )
    }
}
