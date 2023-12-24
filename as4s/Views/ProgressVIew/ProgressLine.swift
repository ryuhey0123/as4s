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

#Preview {
    struct PreviewWrapper: View {
        @State var value: Double = 0.0
        @State var total: Double = 100.0
        
        let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        
        var body: some View {
            ProgressLine(value: $value, total: $total, color: .accentColor)
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
