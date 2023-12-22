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
    @State private var showingOutput: Bool = true
    @State private var showingInput: Bool = true
    
    var body: some View {
        VStack(spacing: -1.0) {
            VSplit(top: {
                VStack(spacing: -1.0) {
                    ModelView()
                        .onAppear {
                            Actions.addCoordinate(store: store)
                        }
                    Divider()
                }
            }, bottom: {
                VStack(spacing: -1.0) {
                    Divider()
                    InfoView(output: $store.openSeesStdErr, input: $store.openSeesInput, showingOutput: $showingOutput, showingInput: $showingInput)
                }
            })
            .hide(hide)
            .fraction(0.75)
            .constraints(minPFraction: 0.3, minSFraction: 0.15)
            .splitter {
                InfoPrimaryToolbar(hide: $hide, showingAccesary: $showingAccesary)
            }
            
            if showingAccesary {
                Divider()
                InfoSecondaryToolbar(showingOutput: $showingOutput, showingInput: $showingInput)
            }
        }
        .onAppear {
            hide.hide(.secondary)
        }
    }
}

#Preview {
    Detail()
        .environmentObject(Store())
}
