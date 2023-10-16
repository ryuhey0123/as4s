//
//  Store+Document.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let as4Doument = UTType(exportedAs: "jp.rfst.as4s.model")
}

extension Store: ReferenceFileDocument {
    typealias Snapshot = AS4Model

    static var readableContentTypes: [UTType] { [.as4Doument] }
    
    func snapshot(contentType: UTType) throws -> Snapshot {
        self.model
    }
    
    func fileWrapper(snapshot: AS4Model, configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(snapshot)
        let fileWrapper = FileWrapper(regularFileWithContents: data)
        return fileWrapper
    }
}
