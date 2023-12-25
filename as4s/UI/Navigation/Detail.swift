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
    
    @State private var showingAccesary: Bool = false
    @State private var currentHeight: CGFloat = 200
    @State private var storeHeight: CGFloat = 200

    var body: some View {
            ZStack(alignment: .bottom) {
                ModelView()
                
                GeometryReader { geometry in
                    VStack {
                        PrimaryInfoToolbar(showingAccesary: $showingAccesary)
                            .position(x: geometry.frame(in: .local).width / 2, y: currentHeight)
                            .gesture(
                                DragGesture()
                                    .onChanged { gesture in
                                        currentHeight = gesture.location.y
                                    }
                            )
                            .zIndex(2.0)
                            .onChange(of: showingAccesary) {
                                withAnimation {
                                    if showingAccesary {
                                        currentHeight = storeHeight
                                    } else {
                                        storeHeight = currentHeight
                                        currentHeight = geometry.frame(in: .local).height - 12.5
                                    }
                                }
                            }
                        
                        TextinfoView(output: $store.openSeesStdErr, input: $store.openSeesInput)
                            .frame(height: geometry.frame(in: .local).height - currentHeight - 12.5)
                            .background(.ultraThinMaterial)
                            .zIndex(1.0)
                    }
            }
        }
    }
}

#Preview {
    Detail()
        .environmentObject(Store.debug)
}
