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
    
    @State private var currentPosition: CGFloat = 200
    @State private var storePosition: CGFloat = 200
    
    let subToolBarHeightHalf = 12.5
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                PrimaryInfoToolbar(showingAccesary: $showingAccesary)
                    .position(x: geometry.frame(in: .global).width / 2, y: currentPosition)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                withAnimation(.linear(duration: 0.1)) {
                                    currentPosition = min(max(100, gesture.location.y), geometry.frame(in: .global).height - 100)
                                }
                                showingAccesary = true
                            }
                    )
                    .onChange(of: showingAccesary) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            if showingAccesary {
                                currentPosition = storePosition
                            } else {
                                storePosition = currentPosition
                                currentPosition = geometry.frame(in: .global).height - subToolBarHeightHalf
                            }
                        }
                    }
                    .zIndex(2)
                
                TextinfoView(output: $store.openSeesStdErr, input: $store.openSeesInput)
                    .frame(height: max(0, geometry.frame(in: .global).height - currentPosition - subToolBarHeightHalf))
                    .background(.ultraThinMaterial)
                    .zIndex(1)
            }
            .onAppear {
                currentPosition = showingAccesary ? 200 : geometry.frame(in: .global).height - subToolBarHeightHalf
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
