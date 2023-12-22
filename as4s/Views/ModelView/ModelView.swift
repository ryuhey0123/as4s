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
                metalView.clearColor = .init(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0)
                controller = GraphicController(metalView: metalView, scene: store.scene)
            }
    }
}

#Preview {
    ModelView()
        .environmentObject(Store())
}
