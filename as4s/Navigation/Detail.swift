//
//  Detail.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI
import SplitView

struct Detail: View {
    @EnvironmentObject var store: Store
    
    @State private var hide = SideHolder()
    @State private var showingAccesary: Bool = false

    var body: some View {
        ZStack {
            ModelView()
            
            VStack(spacing: -1.0) {
                VSplit(top: {
                    EmptyView()
                }, bottom: {
                    VStack(spacing: -1.0) {
                        Divider()
                        InfoView(output: $store.openSeesStdErr, input: $store.openSeesInput)
                    }
                    .background(.thickMaterial)
                })
                .hide(hide)
                .fraction(0.75)
                .constraints(minPFraction: 0.3, minSFraction: 0.15)
                .splitter {
                    InfoPrimaryToolbar(hide: $hide, showingAccesary: $showingAccesary)
                }
            }
            .onAppear {
                if !showingAccesary {
                    hide.hide(.secondary)
                }
            }
            
        }
    }
}

#Preview {
    Detail()
        .environmentObject(Store.debug)
}
