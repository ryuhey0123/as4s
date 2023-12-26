//
//  InformationPanel.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/26.
//

import SwiftUI

struct InformationPanel: View {
    @EnvironmentObject var store: Store
    
    @State private var currentHeight: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                PrimaryInfoToolbarView(geometry: geometry, currentHeight: $currentHeight)
                    .zIndex(1)
                TextinfoView(output: $store.openSeesStdErr, input: $store.openSeesInput)
                    .frame(height: currentHeight)
            }
            
        }
    }
}

fileprivate struct PrimaryInfoToolbarView: View {
    var geometry: GeometryProxy
    @Binding var currentHeight: CGFloat
    
    @State private var showingAccesary: Bool = false
    @State private var storedHeight: CGFloat = 200
    
    let subToolBarHeightHalf: CGFloat = 12.5
    let minTopHeight: CGFloat = 100
    let minBottomHeight: CGFloat = 100
    
    var body: some View {
        PrimaryInfoToolbar(showingAccesary: $showingAccesary)
            .position(x: geometry.frame(in: .global).width / 2,
                      y: geometry.frame(in: .global).height - currentHeight - subToolBarHeightHalf)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        withAnimation(.linear(duration: 0.1)) {
                            let height = geometry.frame(in: .global).height
                            currentHeight = clamp(value: height - gesture.location.y,
                                                  in: minTopHeight...height - minBottomHeight)
                        }
                        showingAccesary = true
                    }
            )
            .onChange(of: showingAccesary) {
                withAnimation(.easeInOut(duration: 0.2)) {
                    if showingAccesary {
                        currentHeight = storedHeight
                    } else {
                        storedHeight = currentHeight
                        currentHeight = 0
                    }
                }
            }
    }
    
    private func clamp(value: CGFloat, in range: ClosedRange<CGFloat>) -> CGFloat {
        min(max(value, range.lowerBound), range.upperBound)
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
