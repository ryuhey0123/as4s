//
//  Store.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic

final class Store: ObservableObject {
    
    let model: Model
    
    @Published var scene: GraphicScene = GraphicScene()
    
    var openSeesBinaryURL: URL
    var tclEnvironment: [String : String]
    
    var openSeesStdOutData: Data?
    var openSeesStdErrData: Data?
    
    init(model: Model = Model()) {
        guard let binaryURL = Bundle.main.url(forResource: "OpenSees", withExtension: nil) else {
            fatalError("Not found OpenSees")
        }
        
        guard let tclURL = Bundle.main.url(forResource: "init.tcl", withExtension: nil) else {
            fatalError("Not found init.tcl")
        }
        
        var environment = ProcessInfo.processInfo.environment
        environment["TCL_LIBRARY"] = tclURL.deletingLastPathComponent().path
        
        self.model = model
        self.openSeesBinaryURL = binaryURL
        self.tclEnvironment = environment
    }
    
    convenience init(configuration: ReadConfiguration) throws {
//        guard let data = configuration.file.regularFileContents else {
//            throw CocoaError(.fileReadCorruptFile)
//        }
//        
//        let model = try JSONDecoder().decode(Model.self, from: data)
//        self.init(model: model)
        fatalError()
    }
}

class SharedStore: ObservableObject {
    var stores: [Store] = []
}
