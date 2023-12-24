//
//  ProgressBar.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/24.
//

import SwiftUI

struct ProgressBar: View {
    @Binding var title: String
    @Binding var subtitle: String
    
    @State private var progress: Double = 50
    @State var total: Double = 100.0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                Text(title)
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
        ProgressBar(title: .constant("Analysing..."), subtitle: .constant("Building OpenSees Command File"))
            .frame(width: 600)
            .padding()
        ProgressBar(title: .constant("Analysing..."), subtitle: .constant("Building OpenSees Command File"))
            .frame(width: 300)
            .padding()
    }
}
