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
            TextFormattingRule(key: .foregroundColor, value: NSColor.gray),
        ]),
        HighlightRule(pattern: number, formattingRules: [
            TextFormattingRule(key: .foregroundColor, value: NSColor.orange),
        ]),
        HighlightRule(pattern: integer, formattingRules: [
            TextFormattingRule(key: .foregroundColor, value: NSColor.cyan),
        ]),
        HighlightRule(pattern: arguments, formattingRules: [
            TextFormattingRule(key: .foregroundColor, value: NSColor.gray),
        ]),
        HighlightRule(pattern: function, formattingRules: [
            TextFormattingRule(fontTraits: [.bold]),
            TextFormattingRule(key: .foregroundColor, value: NSColor.systemPink),
        ]),
    ]
}
