//
//  NSPoint+Extension.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/11/17.
//

import Foundation

extension NSPoint {
    
    func distance(to p: NSPoint) -> CGFloat {
        sqrt(pow((p.x - x), 2) + pow((p.y - y), 2))
    }
    
    func isClose(to p: NSPoint, radius: CGFloat) -> Bool {
        distance(to: p) < radius
    }
}
