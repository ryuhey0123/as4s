//
//  ObjectInspector.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/19.
//

import SwiftUI

struct ObjectInspector: View {
    @Binding var selectedNodes: Set<Node>
    @Binding var selectedBeams: Set<BeamColumn>
    
    var body: some View {
        if selectedNodes.count != 0 && selectedBeams.count != 0 {
            Text("Selected \(selectedNodes.count) nodes.")
            Text("Selected \(selectedBeams.count) beams.")
        } else if selectedNodes.count == 1 {
            NodeInspector(node: selectedNodes.first!)
        } else if selectedBeams.count == 1 {
            BeamInspector(beam: selectedBeams.first!)
        }
    }
}
