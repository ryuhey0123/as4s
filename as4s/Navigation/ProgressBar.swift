//
//  ProgressBar.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/24.
//

import SwiftUI

struct ProgressBar: View {
    var body: some View {
        HStack {
            Text("Hello, World!")
                .font(.callout)
            Spacer(minLength: 200)
            Text("Selected 2 Nodes")
                .font(.callout)
                .foregroundStyle(.secondary)
        }
        .padding(6)
        .background(.selection)
        .containerShape(
            RoundedRectangle(cornerRadius: 5)
        )
    }
}

#Preview {
    ProgressBar()
        .padding()
}
