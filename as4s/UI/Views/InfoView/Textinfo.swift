//
//  Textinfo.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI
import HighlightedTextEditor

struct Textinfo: View {
    @Binding var output: String
    @Binding var input: String
    
    @State private var showingOutput: Bool = true
    @State private var showingInput: Bool = true
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack(spacing: -1.0) {
                if showingOutput {
                    OutputText(text: $output)
                        .transition(.move(edge: .leading))
                }
                Divider()
                if showingInput {
                    InputText(text: $input)
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.interactiveSpring, value: showingOutput)
            .animation(.interactiveSpring, value: showingInput)
            
            Divider()
            
            Toolbar(showingOutput: $showingOutput, showingInput: $showingInput)
                .background(.ultraThinMaterial)
        }
        .background(.background)
    }
    
    struct InputText: View {
        @Binding var text: String
        
        var body: some View {
            VStack {
                HighlightedTextEditor(text: $text, highlightRules: OpenSeesHighlightRule.rules)
                    .introspect { editor in
                        editor.scrollView?.drawsBackground = false
                        editor.textView.drawsBackground = false
                    }
            }
        }
    }
    
    struct OutputText: View {
        @Binding var text: String
        
        @State private var showLabel: Bool = true
        
        var body: some View {
            ScrollView(.vertical) {
                ZStack {
                    Text(text)
                        .font(.callout)
                        .fontDesign(.monospaced)
                        .multilineTextAlignment(.leading)
                        .textSelection(.enabled)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    struct Toolbar: View {
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
}


// MARK: - Previews

#Preview {
    Textinfo(output: .constant(SampleText.output), input: .constant(SampleText.input))
        .frame(width: 600)
}

#Preview("Input") {
    Textinfo.OutputText(text: .constant(SampleText.output))
}

#Preview("Output") {
    struct PreviewWrapper: View {
        @State var text: String = SampleText.input

        var body: some View {
            Textinfo.InputText(text: $text)
        }
    }
    return PreviewWrapper()
}

#Preview("Toolbar") {
    struct PreviewWrapper: View {
        @State var showingOutput: Bool = false
        @State var showingInput: Bool = false
        
        var body: some View {
            Textinfo.Toolbar(showingOutput: $showingOutput, showingInput: $showingInput)
        }
    }
    return PreviewWrapper()
}
