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
    
    var color: Color {
        switch title {
            case .modeling: .accentColor
            case .analysing: .accentColor
            case .success: .green
            case .error: .red
            case .warning: .yellow
        }
    }
    
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
                    Button {
                        
                    } label: {
                        Text(String(warnings.count))
                    }
                    .buttonStyle(CustomButtonStyle(color: .yellow))
                }
                
                if !errors.isEmpty {
                    Button {
                        
                    } label: {
                        Text(String(errors.count))
                    }
                    .buttonStyle(CustomButtonStyle(color: .red))
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
    
    struct CustomButtonStyle: ButtonStyle {
        var color: Color
        
        public func makeBody(configuration: Self.Configuration) -> some View {
            configuration.label
                .font(.callout)
                .bold()
                .padding(.horizontal, 8)
                .foregroundColor(color == .yellow ? .black : .black)
                .background(
                    RoundedRectangle(cornerRadius: 15.0, style: .continuous)
                        .fill(color)
                )
                .opacity(configuration.isPressed ? 0.4 : 1.0)
        }
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
