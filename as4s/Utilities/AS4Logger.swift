//
//  AS4Logger.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/16.
//

import os

class AS4Logger {
    static let actionLogger = Logger(subsystem: "jp.rfst.as4s", category: "Actions")
    
    static func logAction(_ message: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = dateFormatter.string(from: Date())
        actionLogger.debug("[\(dateString)] \(message)")
    }
}
