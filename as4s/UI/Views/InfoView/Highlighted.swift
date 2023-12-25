//
//  Highlighted.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/25.
//

import SwiftUI
import HighlightedTextEditor

struct Highlighted: View {
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

#Preview {
    struct PreviewWrapper: View {
        @State var text: String = SampleText.input
        
        var body: some View {
            Highlighted(text: $text)
        }
    }
    return PreviewWrapper()
}
