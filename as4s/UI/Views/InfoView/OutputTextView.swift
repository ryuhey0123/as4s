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
        ZStack(alignment: .top) {
            ScrollView(.vertical) {
                ZStack {
                    Text("\n\n\n" + text)
                        .font(.callout)
                        .fontDesign(.monospaced)
                        .multilineTextAlignment(.leading)
                        .textSelection(.enabled)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(.leading)
                }
            }
            if showLabel {
                HStack {
                    Text("\(title)")
                        .font(.headline)
                        .foregroundStyle(.tertiary)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        .background(.ultraThinMaterial)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    Spacer()
                }
                .padding(7)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    OutputTextView(title: "Input", text: .constant(SampleText.output))
}
