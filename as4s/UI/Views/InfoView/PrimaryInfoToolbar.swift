//
//  PrimaryInfoToolbar.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI

struct PrimaryInfoToolbar: View {
    @Binding var showingAccesary: Bool
    
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
    struct PreviewWrapper: View {
        @State var showingAccesary: Bool = false
        
        var body: some View {
            PrimaryInfoToolbar(showingAccesary: $showingAccesary)
        }
    }
    return PreviewWrapper()
}
