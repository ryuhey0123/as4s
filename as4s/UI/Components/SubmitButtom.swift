//
//  SubmitButtom.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/23.
//

import SwiftUI

struct SubmitButtom: View {
    var cancelAction: () -> ()
    var submitAction: () -> ()
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                cancelAction()
            } label: {
                Text("Reset")
            }
            Button {
                submitAction()
            } label: {
                Text("OK")
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    SubmitButtom(cancelAction: {}, submitAction: {})
        .frame(width: 300)
        .border(.secondary)
        .padding()
}
