//
//  InfoPrimaryToolbar.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI
import SplitView

struct InfoPrimaryToolbar: SplitDivider {
    @Binding var hide: SideHolder
    @Binding var showingAccesary: Bool
    
    var layout: LayoutHolder = LayoutHolder()
    var styling: SplitStyling = SplitStyling(visibleThickness: 25)
    
    var body: some View {
        ZStack {
            HStack {
                Text("Hello!")
                    .foregroundStyle(.secondary)
                Spacer()
                Toggle(isOn: $showingAccesary, label: {
                    Label("Show Information", systemImage: "square.bottomthird.inset.filled")
                        .labelStyle(.iconOnly)
                })
                .toggleStyle(.button)
                .buttonStyle(.borderless)
                .onChange(of: showingAccesary) {
                    withAnimation(.interactiveSpring) {
                        hide.toggle()
                    }
                }
            }
            .padding(.horizontal)
            .frame(height: 25)
            .contentShape(
                Rectangle()
            )
            
            HStack {
                Spacer()
                    .frame(width: 100)
                Rectangle()
                    .fill(.clear)
                    .onHover { hovering in
                        if hovering {
                            NSCursor.resizeUpDown.push()
                        } else {
                            NSCursor.pop()
                        }
                    }
                Spacer()
                    .frame(width: 100)
            }
            .frame(height: 25)
        }
        .background(.thickMaterial)
    }
}

#Preview {
    InfoPrimaryToolbar(hide: .constant(SideHolder()), showingAccesary: .constant(true))
}
