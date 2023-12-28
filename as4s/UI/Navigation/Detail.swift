//
//  Detail.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI

struct Detail: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
            ZStack(alignment: .bottom) {
                ModelView()
                InformationPanel()
        }
    }
}

#Preview {
    Detail()
        .environmentObject(Store.debug)
}
