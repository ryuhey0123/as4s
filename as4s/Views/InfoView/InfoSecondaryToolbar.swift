//
//  InfoSecondaryToolbar.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI

struct InfoSecondaryToolbar: View {
    @Binding var showingOutput: Bool
    @Binding var showingInput: Bool
    
    var body: some View {
        HStack {
            Spacer()
            Toggle(isOn: $showingOutput, label: {
                Label("Show Output", systemImage: "square.leftthird.inset.filled")
                    .labelStyle(.iconOnly)
            })
            .toggleStyle(.button)
            .buttonStyle(.borderless)
            .onChange(of: showingOutput) {
                if !showingOutput && !showingInput {
                    showingInput = true
                    showingOutput = true
                }
            }
            
            Toggle(isOn: $showingInput, label: {
                Label("Show Input", systemImage: "square.rightthird.inset.filled")
                    .labelStyle(.iconOnly)
            })
            .toggleStyle(.button)
            .buttonStyle(.borderless)
            .onChange(of: showingInput) {
                if !showingOutput && !showingInput {
                    showingInput = true
                    showingOutput = true
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 25)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var showingOutput: Bool = false
        @State var showingInput: Bool = false
        
        var body: some View {
            InfoSecondaryToolbar(showingOutput: $showingOutput, showingInput: $showingInput)
        }
    }
    return PreviewWrapper()
}
