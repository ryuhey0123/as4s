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
                ResizableToolbar(geometry: geometry, currentHeight: $currentHeight)
                    .zIndex(1)
                Textinfo(output: $store.openSeesStdErr, input: $store.openSeesInput)
                    .frame(height: currentHeight)
            }
            
        }
    }
    
    struct ResizableToolbar: View {
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
        
        func clamp(value: CGFloat, in range: ClosedRange<CGFloat>) -> CGFloat {
            min(max(value, range.lowerBound), range.upperBound)
        }
    }
    
    struct PrimaryInfoToolbar: View {
        @Binding var showingAccesary: Bool
        
        var body: some View {
            VStack(spacing: -1.0) {
                ZStack {
                    HStack {
                        Text("Hello!")
                            .foregroundStyle(.secondary)
                        Spacer()
                        Toggle(isOn: $showingAccesary, label: {
                            Label("Show Information", systemImage: "square.bottomthird.inset.filled")
                                .labelStyle(.iconOnly)
                        })
                        .toggleStyle(.button)
                        .buttonStyle(.borderless)
                    }
                    .padding(.horizontal)
                    .frame(height: 25)
                    .contentShape(
                        Rectangle()
                    )
                    
                    HStack {
                        Spacer()
                            .frame(width: 100)
                        Rectangle()
                            .fill(.clear)
                            .onHover { hovering in
                                if hovering {
                                    NSCursor.resizeUpDown.push()
                                } else {
                                    NSCursor.pop()
                                }
                            }
                        Spacer()
                            .frame(width: 100)
                    }
                    .frame(height: 25)
                }
                Divider()
            }
            .background(.background)
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

#Preview("Toolbar") {
    struct PreviewWrapper: View {
        @State var showingAccesary: Bool = false
        
        var body: some View {
            InformationPanel.PrimaryInfoToolbar(showingAccesary: $showingAccesary)
        }
    }
    return PreviewWrapper()
}
