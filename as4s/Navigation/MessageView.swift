//
//  MessageView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/24.
//

import SwiftUI

struct MessageView: View {
    @Binding var messages: [String]
    
    var body: some View {
        List {
            ForEach(messages, id: \.self) { message in
                Text(message)
                    .padding(.vertical, 5)
            }
        }
        .scrollContentBackground(.hidden)
        .background(.ultraThinMaterial)
    }
}

#Preview {
    MessageView(messages: .constant([
        "Someting happend. Oh my god. But you can check this massege.",
        "Someting happend. Oh my god. But you can check this massege.",
        "Someting happend. Oh my god. But you can check this massege.",
        "Someting happend. Oh my god. But you can check this massege.",
        "Someting happend. Oh my god. But you can check this massege.",
        "Someting happend. Oh my god. But you can check this massege.",
        "Someting happend. Oh my god. But you can check this massege.",
        "Someting happend. Oh my god. But you can check this massege.",
    ]))
    .frame(width: 300)
}
