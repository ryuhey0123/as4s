//
//  as4sDocument.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static let as4Doument = UTType(exportedAs: "jp.rfst.as4s.model")
}

struct as4sDocument: FileDocument {
    var model: AS4Model

    init() {
        self.model = AS4Model()
    }

    static var readableContentTypes: [UTType] { [.as4Doument] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let model = try? JSONDecoder().decode(AS4Model.self, from: data)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        self.model = model
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try JSONEncoder().encode(model)
        return .init(regularFileWithContents: data)
    }
}
