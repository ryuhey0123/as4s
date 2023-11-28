//
//  AS4Logger.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/16.
//

import os
import Foundation

enum Logger {
    
    private enum LogCategory: String {
        case action = "Action"
    }
    
    public static let action: os.Logger = .init(
        subsystem: Bundle.main.bundleIdentifier!,
        category: LogCategory.action.rawValue
    )
}
