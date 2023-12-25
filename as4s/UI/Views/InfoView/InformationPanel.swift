//
//  InformationPanel.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/26.
//

import SwiftUI

struct InformationPanel: View {
    @EnvironmentObject var store: Store
    
    @State private var showingAccesary: Bool = false
    @State private var currentHeight: CGFloat = 0
    @State private var storeHeight: CGFloat = 200
    
    let subToolBarHeightHalf: CGFloat = 12.5
    let minTopHeight: CGFloat = 100
    let minBottomHeight: CGFloat = 100
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                PrimaryInfoToolbar(showingAccesary: $showingAccesary)
                    .position(x: geometry.frame(in: .global).width / 2,
                              y: geometry.frame(in: .global).height - currentHeight - subToolBarHeightHalf)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                withAnimation(.linear(duration: 0.1)) {
                                    let height = geometry.frame(in: .global).height
                                    currentHeight = height - min(max(minBottomHeight, gesture.location.y), height - minTopHeight)
                                }
                                showingAccesary = true
                            }
                    )
                    .onChange(of: showingAccesary) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if showingAccesary {
                                currentHeight = storeHeight
                            } else {
                                storeHeight = currentHeight
                                currentHeight = 0
                            }
                        }
                    }
                    .zIndex(2)
                
                TextinfoView(output: $store.openSeesStdErr, input: $store.openSeesInput)
                    .frame(height: currentHeight)
                    .background(.ultraThinMaterial)
                    .zIndex(1)
            }
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        var body: some View {
            ZStack(alignment: .bottom) {
                Text("Hello")
                    .frame(width: 600, height: 400)
                    .border(.red)
                    .background(.quaternary)
                
                InformationPanel()
                    .border(.blue)
                    .environmentObject(Store.debug)
            }
        }
    }
    return PreviewWrapper()
}
