//
//  OpenSeesHighlightRule.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/25.
//

import AppKit
import Foundation
import HighlightedTextEditor

struct OpenSeesHighlightRule {
    
    static let comment = try! NSRegularExpression(pattern: "#.*", options: [])
    
    static let integer = try! NSRegularExpression(pattern: "(?<=\\s|^)-?\\d+(?=\\s|$)", options: [])
    
    static let number = try! NSRegularExpression(pattern: "(-|)\\d+\\.(\\d+)", options: [])
    
    static let arguments = try! NSRegularExpression(pattern: "-[a-z]+", options: [])
    
    static let function = try! NSRegularExpression(pattern: """
^(wipe|model|node|section|geomTransf|element|fix|timeSeries|pattern|load\
|recorder|system|numberer|constraints|integrator|algorithm|analysis|analyze|print)
""", options: [.anchorsMatchLines])
    
    static let rules: [HighlightRule] = [
        HighlightRule(pattern: .all, formattingRules: [
            TextFormattingRule(key: .font, value: NSFont.monospacedSystemFont(ofSize: 12, weight: .regular))
        ]),
        HighlightRule(pattern: comment, formattingRules: [
            TextFormattingRule(fontTraits: [.italic]),
            TextFormattingRule(key: .foregroundColor,
                               value: Color.gray),
        ]),
        HighlightRule(pattern: number, formattingRules: [
            TextFormattingRule(key: .foregroundColor, 
                               value: Color.orange),
        ]),
        HighlightRule(pattern: integer, formattingRules: [
            TextFormattingRule(key: .foregroundColor,
                               value: Color.yellow),
        ]),
        HighlightRule(pattern: arguments, formattingRules: [
            TextFormattingRule(key: .foregroundColor,
                               value: Color.purple),
        ]),
        HighlightRule(pattern: function, formattingRules: [
            TextFormattingRule(fontTraits: [.bold]),
            TextFormattingRule(key: .foregroundColor,
                               value: Color.pink),
        ]),
    ]
    
    enum Color {
        static let orange = NSColor(srgbRed: 255 / 255, green: 128 / 255, blue: 111 / 255, alpha: 1.0)
        static let yellow = NSColor(srgbRed: 218 / 255, green: 201 / 255, blue: 124 / 255, alpha: 1.0)
        static let pink = NSColor(srgbRed: 255 / 255, green: 122 / 255, blue: 179 / 255, alpha: 1.0)
        static let blue = NSColor(srgbRed: 80 / 255, green: 175 / 255, blue: 203 / 255, alpha: 1.0)
        static let green = NSColor(srgbRed: 121 / 255, green: 194 / 255, blue: 179 / 255, alpha: 1.0)
        static let purple = NSColor(srgbRed: 178 / 255, green: 129 / 255, blue: 235 / 255, alpha: 1.0)
        static let gray = NSColor(srgbRed: 127 / 255, green: 140 / 255, blue: 152 / 255, alpha: 1.0)
    }
}
