//
//  NodeInspector.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/19.
//

import SwiftUI

struct NodeInspector: View {
    var node: Node
    
    @State private var massExpended: Bool = false
    @State private var supportExpended: Bool = false
    
    var body: some View {
        VStack {
            Text("Node (ID: \(node.id))")
                .font(.headline)
                .foregroundStyle(.secondary)
            
            List {
                Section {
                    LabeledVector(value: node.position)
                } header: {
                    Text("Coordinate")
                }
                
                Section(isExpanded: $massExpended) {
                    LabeledVector(value: float3(node.massValues ?? [0, 0, 0]), unit: "")
                } header: {
                    Text("Mass")
                }
                
                Section(isExpanded: $supportExpended) {
                    LabeledVector(value: float3(node.massValues ?? [0, 0, 0]), unit: "")
                    LabeledVector(value: float3(node.massValues ?? [0, 0, 0]), unit: "")
                } header: {
                    Text("Support")
                }
            }
            .listStyle(.sidebar)
            .scrollContentBackground(.hidden)
        }
        .background(.ultraThinMaterial)
    }
    
    struct SupportValue: View {
        var label: String
        var value: Int
        
        var body: some View {
            LabeledContent(content: {
                Text(String(value))
            }, label: {
                Text(label)
            })
        }
    }

}

#Preview {
    NodeInspector(node: Node(id: 1, position: .init(1000, 2000, 1000.58)))
        .frame(width: 300, height: 600)
}

