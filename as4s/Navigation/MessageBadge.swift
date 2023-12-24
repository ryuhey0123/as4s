//
//  MessageBadge.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/24.
//

import SwiftUI

struct MessageBadge: View {
    @Binding var messages: [String]
    var forgroundColor: Color
    var bacgroundColor: Color
    var edge: Edge = .bottom
    
    @State private var showingWarnings: Bool = false
    
    var body: some View {
        Button {
            showingWarnings = true
        } label: {
            Text(String(messages.count))
        }
        .buttonStyle(CustomButtonStyle(forgroundColor: forgroundColor, bacgroundColor: bacgroundColor))
        .popover(isPresented: $showingWarnings, arrowEdge: edge){
            MessageView(messages: $messages)
        }
    }
    
    private struct CustomButtonStyle: ButtonStyle {
        var forgroundColor: Color
        var bacgroundColor: Color
        
        public func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .font(.callout)
                .bold()
                .padding(.horizontal, 8)
                .foregroundColor(forgroundColor)
                .background(
                    RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                        .fill(bacgroundColor)
                )
                .opacity(configuration.isPressed ? 0.4 : 1.0)
        }
    }
}

#Preview {
    MessageBadge(messages: .constant([
        "Someting happend. Oh my god. But you can check this massege.",
        "Someting happend. Oh my god. But you can check this massege.",
        "Someting happend. Oh my god. But you can check this massege.",
    ]), forgroundColor: .black, bacgroundColor: .yellow)
    .padding()
}
