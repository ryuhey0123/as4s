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
            }
        }
    }
}

#Preview {
    ObjectInspector(selectedObjects: .constant([
        Node(id: 1, position: .zero)
    ]))
}
