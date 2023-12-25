//
//  ModelView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/15.
//

import SwiftUI

struct ModelView: View {
    @EnvironmentObject var store: Store
    
    @State private var metalView = MVCView()
    @State private var controller: GraphicController?
    
    public var body: some View {
        MVCViewRepresentable(view: $metalView, controller: controller, store: store)
            .onAppear {
                metalView.clearColor = .init(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.0)
                controller = GraphicController(metalView: metalView, scene: store.scene)
                
                Actions.addCoordinate(store: store)
                Actions.buildDebugModel(store: store)
            }
    }
}

#Preview {
    ModelView()
        .environmentObject(Store.debug)
}
