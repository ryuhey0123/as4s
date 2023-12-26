//
//  TextinfoView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI

struct TextinfoView: View {
    @Binding var output: String
    @Binding var input: String
    
    @State private var showingOutput: Bool = true
    @State private var showingInput: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: -1.0) {
                if showingOutput {
                    OutputTextView(title: "Output", text: $output)
                        .transition(.move(edge: .leading))
                }
                Divider()
                if showingInput {
                    CommandEditorView(text: $input)
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.interactiveSpring, value: showingOutput)
            .animation(.interactiveSpring, value: showingInput)
            
            Divider()
            
            SecondaryInfoToolbar(showingOutput: $showingOutput, showingInput: $showingInput)
                .background(.ultraThinMaterial)
        }
        .background(.background)
    }
}

#Preview {
    TextinfoView(output: .constant(SampleText.output), input: .constant(SampleText.input))
        .frame(width: 600)
}
