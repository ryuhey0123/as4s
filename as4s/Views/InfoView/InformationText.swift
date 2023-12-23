//
//  InformationText.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct InformationText: View {
    var title: String
    @Binding var text: String
    
    @State private var showLabel: Bool = true
    
//    struct OffsetPreferenceKey: PreferenceKey {
//        static var defaultValue = CGFloat.zero
//        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
//            value += nextValue()
//        }
//    }
    
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical) {
                ZStack {
//                    GeometryReader { geometry in
//                        Color.clear
//                            .preference(
//                                key: OffsetPreferenceKey.self,
//                                // FIXME: Cannnot get window height
//                                value: geometry.frame(in: .global).origin.y + geometry.bounds(of: .scrollView)!.height
//                            )
//                    }
                    Text("\n\n\n" + text)
                        .font(.callout)
                        .fontDesign(.monospaced)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(.leading)
                }
//                .onPreferenceChange(OffsetPreferenceKey.self) { value in
//                    withAnimation {
//                        showLabel = value > 670
//                    }
//                }
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
    InformationText(title: "Input", text: .constant(SampleText.input))
}
