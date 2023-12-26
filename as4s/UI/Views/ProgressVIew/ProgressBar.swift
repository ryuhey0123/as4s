//
//  ProgressBar.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/24.
//

import SwiftUI

enum ProgressStates: String {
    case modeling = "Modeling"
    case analysing = "Analysing..."
    case success = "Success"
    case error = "Error"
    case warning = "Warning"
}

struct ProgressBar: View {
    @Binding var title: ProgressStates
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
    
    struct ProgressLine: View {
        @Binding var value: Double
        @Binding var total: Double
        var color: Color
        
        var body: some View {
            GeometryReader { geometry in
                Path { path in
                    let y = geometry.frame(in: .local).maxY - 1
                    path.move(to: .init(x: geometry.frame(in: .local).minX, y: y))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                }
                .stroke(
                    .linearGradient(
                        Gradient(stops: [
                            .init(color: color, location: 0.0),
                            .init(color: color, location: value / total),
                            .init(color: .clear, location: value / total)
                        ]),
                        startPoint: UnitPoint(x: 0.0, y: 0.0),
                        endPoint: UnitPoint(x: 1.0, y: 0.0)),
                    style: StrokeStyle(lineWidth: 2))
            }
            .frame(height: 2)
        }
    }
}


// MARK: - Previews

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

#Preview("Progress Line") {
    struct PreviewWrapper: View {
        @State var value: Double = 0.0
        @State var total: Double = 100.0
        
        let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        
        var body: some View {
            ProgressBar.ProgressLine(value: $value, total: $total, color: .accentColor)
                .padding()
                .onReceive(timer) { _ in
                    if value <= 100 {
                        value += 1
                    } else {
                        value = 0
                    }
                }
        }
    }
    return PreviewWrapper()
}
