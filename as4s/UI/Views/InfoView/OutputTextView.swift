//
//  OutputTextView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct OutputTextView: View {
    var title: String
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

#Preview {
    OutputTextView(title: "Input", text: .constant(SampleText.output))
}
