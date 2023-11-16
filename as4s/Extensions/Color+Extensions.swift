// Ref: http://brunowernimont.me/howtos/make-swiftui-color-codable

import SwiftUI

#if os(iOS)
import UIKit
#elseif os(macOS)
import AppKit
#endif

#if os(macOS)
typealias SystemColor = NSColor
#else
typealias SystemColor = UIColor
#endif


// MARK: - Codable

extension Color {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        // #if os(macOS)
        // SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let color = CIColor(cgColor: SystemColor(self).cgColor)
        r = color.red
        g = color.green
        b = color.blue
        a = color.alpha
        
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        // #else
        // guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
        //     // Pay attention that the color should be convertible into RGB format
        //     // Colors using hue, saturation and brightness won't work
        //     return nil
        // }
        // #endif
        
        return (r, g, b, a)
    }
}

extension SystemColor {
    var rgba: (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        let color = CIColor(cgColor: self.cgColor)
        return (color.red, color.green, color.blue, color.alpha)
    }
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        self.init(red: r, green: g, blue: b)
    }
    
    public func encode(to encoder: Encoder) throws {
        let colorComponents = self.rgba
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
    }
}


// MARK: - RawRepresentable

extension Color: RawRepresentable {
    public typealias RawValue = String
    
    public init?(rawValue: String) {
        let components = rawValue.components(separatedBy: ",")
        let r = Double(components[0]) ?? .zero
        let g = Double(components[1]) ?? .zero
        let b = Double(components[2]) ?? .zero
        let o = Double(components[3]) ?? .zero
        self = .init(.sRGB, red: r, green: g, blue: b, opacity: o)
    }
    
    public var rawValue: String {
        let rgba = self.rgba
        let r = String(format: "%0.8f", rgba.red)
        let g = String(format: "%0.8f", rgba.green)
        let b = String(format: "%0.8f", rgba.blue)
        let o = String(format: "%0.8f", rgba.alpha)
        return [r, g, b, o].joined(separator: ",")
    }
}
