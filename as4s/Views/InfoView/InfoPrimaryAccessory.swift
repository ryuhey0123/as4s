//
//  InfoPrimaryAccessory.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI
import SplitView

struct CustomSplitter: SplitDivider {
    @Binding var hide: SideHolder
    @Binding var showingAccesary: Bool
    
    @State private var hideButton: Bool = false
    @State private var showingInformation: Bool = true
    
    var layout: LayoutHolder = LayoutHolder()
    var styling: SplitStyling = SplitStyling(visibleThickness: 25)
    
    var body: some View {
        HStack {
            Text("Hello!")
                .foregroundStyle(.secondary)
            Spacer()
            Toggle(isOn: $showingInformation, label: {
                Label("Show Information", systemImage: "square.bottomthird.inset.filled")
                    .labelStyle(.iconOnly)
            })
            .toggleStyle(.button)
            .buttonStyle(.borderless)
            .onChange(of: showingInformation) {
                withAnimation(.interactiveSpring) {
                    hide.toggle()
                }
                showingAccesary.toggle()
            }
        }
        .padding(.horizontal)
        .frame(height: 25)
        .contentShape(Rectangle())
    }
}

//#Preview {
//    InfoPrimaryAccessory()
//}
