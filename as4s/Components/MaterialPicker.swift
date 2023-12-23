//
//  MaterialPicker.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct MaterialPicker: View {
    @EnvironmentObject var store: Store
    var title: String = "Material"
    @Binding var selection: Int
    
    var body: some View {
        Picker(title, selection: $selection) {
            ForEach(store.model.materials) {
                Text("\($0.id): \($0.label)").tag($0.id)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var selected: Int = 1
        
        var body: some View {
            MaterialPicker(selection: $selected)
                .environmentObject(Store.debug)
                .border(.secondary)
                .padding()
        }
    }
    return PreviewWrapper()
}
