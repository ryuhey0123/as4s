//
//  ProgressLine.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/24.
//

import SwiftUI

struct ProgressLine: View {
    @Binding var value: Double
    @Binding var total: Double
    
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
                        .init(color: .accentColor, location: 0.0),
                        .init(color: .accentColor, location: value / total),
                        .init(color: .clear, location: value / total)
                    ]),
                    startPoint: UnitPoint(x: 0.0, y: 0.0),
                    endPoint: UnitPoint(x: 1.0, y: 0.0)),
                style: StrokeStyle(lineWidth: 2))
        }
        .frame(height: 2)
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State var value: Double = 30.0
        @State var total: Double = 100.0
        
        let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        
        var body: some View {
            ProgressLine(value: $value, total: $total)
                .padding()
//                .onReceive(timer) { _ in
//                    if value < 100 {
//                        value += 0.1
//                    } else {
//                        value = 0
//                    }
//                }
        }
    }
    return PreviewWrapper()
}
