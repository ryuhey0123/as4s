//
//  ObjectInspector.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/19.
//

import SwiftUI

struct ObjectInspector: View {
    @Binding var selectedObjects: [Selectable]
    
    var body: some View {
        if selectedObjects.count == 1 {
            if let node = selectedObjects[0] as? Node {
                NodeInspector(node: node)
            } else if let beam = selectedObjects[0] as? BeamColumn {
                BeamInspector(beam: beam)
            }
        } else {
            Text("Selected \(selectedObjects.count) Objects.")
        }
    }
}

#Preview {
    ObjectInspector(selectedObjects: .constant([
        Node(id: 1, position: .zero)
    ]))
    .frame(width: 300, height: 600)
}
