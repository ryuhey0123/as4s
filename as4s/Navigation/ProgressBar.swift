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
    case result = "Result"
    case error = "Error"
}

struct ProgressBar: View {
    @Binding var title: ProgressTitles
    @Binding var subtitle: String
    @Binding var progress: Double
    @Binding var total: Double
    
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
            }
            .padding(.vertical, 5)
            .padding(.horizontal, 7)
            ProgressLine(value: $progress, total: $total)
        }
        .background(.selection)
        .clipShape(
            RoundedRectangle(cornerRadius: 6)
        )
    }
}

#Preview {
    VStack {
        ProgressBar(title: .constant(.analysing), subtitle: .constant("Building OpenSees Command File"), progress: .constant(50), total: .constant(100))
            .frame(width: 600)
            .padding()
        ProgressBar(title: .constant(.analysing), subtitle: .constant("Building OpenSees Command File"), progress: .constant(50), total: .constant(100))
            .frame(width: 300)
            .padding()
    }
}
