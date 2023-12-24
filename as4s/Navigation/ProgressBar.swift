//
//  ProgressBar.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/24.
//

import SwiftUI

enum ProgressTitles: String {
    case modeling = "Modeling"
    case analysing = "Analysing..."
    case success = "Success"
    case error = "Error"
    case warning = "Warning"
}

struct ProgressBar: View {
    @Binding var title: ProgressTitles
    @Binding var subtitle: String
    
    @Binding var progress: Double
    @Binding var total: Double
    
    @Binding var errors: [String]
    @Binding var warnings: [String]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                Text(title.rawValue)
                    .font(.callout)
                    .bold()
                
                Spacer()
                
                Text(subtitle)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                
                if !warnings.isEmpty {
                    MessageBadge(messages: $warnings, forgroundColor: .black, bacgroundColor: .yellow)
                }
                
                if !errors.isEmpty {
                    MessageBadge(messages: $errors, forgroundColor: .black, bacgroundColor: .red)
                }
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 7)
            
            ProgressLine(value: $progress, total: $total, color: .accentColor)
        }
        .background(.selection)
        .clipShape(
            RoundedRectangle(cornerRadius: 6)
        )
    }
}

#Preview {
    VStack {
        ProgressBar(title: .constant(.modeling), subtitle: .constant(""),
                    progress: .constant(0), total: .constant(100), errors: .constant([]), warnings: .constant([]))
        .frame(width: 600)
        .padding()
        
        ProgressBar(title: .constant(.analysing), subtitle: .constant("Encoding OpenSees Command File..."),
                    progress: .constant(30), total: .constant(100), errors: .constant([]), warnings: .constant([]))
        .frame(width: 600)
        .padding()
        
        ProgressBar(title: .constant(.success), subtitle: .constant("Finished running 0.254sec"),
                    progress: .constant(100), total: .constant(100), errors: .constant([]), warnings: .constant([]))
        .frame(width: 600)
        .padding()
        
        ProgressBar(title: .constant(.warning), subtitle: .constant(""),
                    progress: .constant(0), total: .constant(100), errors: .constant([]), warnings: .constant([
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                    ]))
        .frame(width: 600)
        .padding()
        
        ProgressBar(title: .constant(.error), subtitle: .constant(""),
                    progress: .constant(0), total: .constant(100), errors: .constant([
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                    ]), warnings: .constant([
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                        "Someting happend. Oh my god. But you can check this massege.",
                    ]))
        .frame(width: 600)
        .padding()
    }
}
