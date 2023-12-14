//
//  Displacementable.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/14.
//

import SwiftUI
import Mevic

protocol Displacementable {
    
    associatedtype GeometryType: MVCGeometry
    
    var dispGeometry: GeometryType! { get set }
    
    var dispLabelGeometry: MVCLabelGeometry! { get set }
}
