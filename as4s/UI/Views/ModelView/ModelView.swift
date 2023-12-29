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
    
    @Environment(\.colorScheme) var colorSheme
    
    public var body: some View {
        MVCViewRepresentable(metalView: $metalView, controller: controller, store: store)
//            .clearColor(colorSheme == .dark ? .init(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0) : .init(red: 0.47, green: 0.47, blue: 0.47, alpha: 1.0))
            .clearColor(.init(red: 0.15, green: 0.15, blue: 0.15, alpha: 1.0))
            .onAppear {
                controller = GraphicController(metalView: metalView, scene: store.scene)
                Actions.addCoordinate(store: store)
            }
    }
}

#Preview {
    ModelView()
        .environmentObject(Store.debug)
}
