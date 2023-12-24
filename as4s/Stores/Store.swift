//
//  Store.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/10/15.
//

import SwiftUI
import Mevic
import OpenSeesCoder

final class Store: ObservableObject, Identifiable {
    
    @StateObject static var debug: Store = Store(debug: true)
    
    let id = UUID()
    
    var openSeesDecoder: OSReslutDecoder
    var openSeesBinaryURL: URL
    var tclEnvironment: [String : String]
    
    @Published var model: Model
    
    @Published var scene: GraphicScene = GraphicScene()
    @Published var selectedObjects: [any Selectable] = []
    @Published var selectedNodes: [Node] = []
    @Published var snapNodes: [Node?] = [nil, nil]
    
    @Published var openSeesInput: String = ""
    @Published var openSeesStdOut: String = ""
    @Published var openSeesStdErr: String = ""
    
    @Published var progressTitle: ProgressTitles = .modeling
    @Published var progressSubtitle: String = ""
    
    @Published var progress: Double = 0.0
    @Published var progressEstimated: Double = 100.0
    
    @Published var warningMessages: [String] = []
    @Published var errorMessages: [String] = []
    
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
        
        self.openSeesDecoder = .init(tclEnvironment: environment, openSeesBinaryURL: binaryURL)
    }
    
    convenience init(debug: Bool) {
        self.init()
        
        if debug {
            Actions.buildDebugModel(store: self)
        }
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
    
    func append(_ rendable: some Renderable) {
        rendable.appendTo(model: model)
        rendable.appendTo(scene: scene)
    }
    
    func append(_ material: Material) {
        model.materials.append(material)
    }
    
    func append(_ reactangle: ReactangleSec) {
        model.reactangle.append(reactangle)
    }
}

class SharedStore: ObservableObject {
    @Published var stores: [Store] = []
    
    subscript(storeId id: Store.ID) -> Store? {
        stores.first { $0.id == id }
    }
}
