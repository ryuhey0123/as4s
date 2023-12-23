//
//  Selectable.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/14.
//

protocol Selectable: Equatable {
    var id: Int { get set }
    var isSelected: Bool { get set }
}

extension Selectable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
