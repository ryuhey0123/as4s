//
//  NodeInspector.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/19.
//

import SwiftUI

struct NodeInspector: View {
    var node: Node
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Node: \(node.id)")
                .font(.headline)
            
            GroupBox(label: Text("Coordinate"), content: {
                PositionValue(label: "X:", value: node.position.x)
                PositionValue(label: "Y:", value: node.position.y)
                PositionValue(label: "Z:", value: node.position.z)
            })
            
            GroupBox(label: Text("Mass"), content: {
                PositionValue(label: "X:", value: node.position.x)
                PositionValue(label: "Y:", value: node.position.y)
                PositionValue(label: "Z:", value: node.position.z)
            })
            
            GroupBox(label: Text("Support"), content: {
                HStack {
                    SupportValue(label: "Tx:", value: 0)
                    SupportValue(label: "Ty:", value: 0)
                    SupportValue(label: "Tz:", value: 0)
                }
                .frame(width: 150, alignment: .leading)
                .padding(.leading, 10)
                HStack {
                    SupportValue(label: "Rx:", value: 0)
                    SupportValue(label: "Rx:", value: 0)
                    SupportValue(label: "Rx:", value: 0)
                }
                .frame(width: 150, alignment: .leading)
                .padding(.leading, 10)
            })
        }
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    struct PositionValue: View {
        var label: String
        var value: Float
        
        var body: some View {
            LabeledContent(content: {
                Text(String(format: "%.2f", value))
                    .font(.body)
            }, label: {
                Text(label)
                    .font(.body)
            })
            .frame(width: 150, alignment: .leading)
            .padding(.leading, 10)
        }
    }
    
    struct SupportValue: View {
        var label: String
        var value: Int
        
        var body: some View {
            LabeledContent(content: {
                Text(String(value))
                    .font(.body)
            }, label: {
                Text(label)
                    .font(.body)
            })
        }
    }

}

#Preview {
    NodeInspector(node: Node(id: 1, position: .init(1000, 2000, 1000.58)))
}

