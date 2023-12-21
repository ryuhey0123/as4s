//
//  TransformView.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/18.
//

import SwiftUI

struct TransformView: View {
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject var sharedStore: SharedStore
    
    @State private var dX: Float = 0
    @State private var dY: Float = 0
    @State private var dZ: Float = 0
    @State private var X: Float = 0
    @State private var Y: Float = 0
    @State private var Z: Float = 0
    
    @State private var mode: Mode = .move
    
    @State private var isCopy: Bool = false
    
    private enum Mode {
        case move, change
    }
    
    let transformConfirm: () -> () = { print("Transform") }
    let changeConfirm: () -> () = { print("Change") }
    let cancelAction = { print("Cancel") }
    
    var body: some View {
        VStack {
            Picker(selection: $mode, label: Text("")) {
                Text("Transform")
                    .tag(Mode.move)
                    .position(x: 40)
                Text("Change")
                    .tag(Mode.change)
                    .position(x: 40)
            }
            .horizontalRadioGroupLayout()
            .pickerStyle(.radioGroup)
            
            HStack {
                PointValueInput(valueX: $dX, valueY: $dY, valueZ: $dZ,
                                x: "dX", y: "dY", z: "dZ")
                .disabled(mode != .move)
                .onSubmit {
                    if let store = sharedStore.activeStore {
                        Actions.moveSelectedObject(to: .init(dX, dY, dZ), store: store)
                        dismiss()
                    }
                }
                PointValueInput(valueX: $X, valueY: $Y, valueZ: $Z,
                                x: "X", y: "Y", z: "Z")
                .disabled(mode != .change)
                .onSubmit {
                    changeConfirm()
                }
            }
            
            Toggle(isOn: $isCopy) {
                Text("Copy")
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                .keyboardShortcut(.escape, modifiers: [])
                Button("OK") {
                    switch mode {
                        case .move:
                            if let store = sharedStore.activeStore {
                                Actions.moveSelectedObject(to: .init(dX, dY, dZ), store: store)
                                    
                            }
                        case .change:
                            changeConfirm()
                    }
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding(.top, 10)
            .frame(maxWidth: 360, alignment: .trailing)
        }
        .padding(20)
        .frame(width: 400, height: 230)
    }
    
    private struct PointValueInput: View {
        @Binding var valueX: Float
        @Binding var valueY: Float
        @Binding var valueZ: Float
        
        var x: String
        var y: String
        var z: String
        
        var body: some View {
            GroupBox {
                Form {
                    NumberFiled(label: x, value: $valueX)
                    NumberFiled(label: y, value: $valueY)
                    NumberFiled(label: z, value: $valueZ)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
        }
    }
    
    private struct NumberFiled: View {
        var label: String
        @Binding var value: Float
        
        var body: some View {
            TextField(value: $value, format: .number) {
                Text("\(label):")
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(width: 120)
        }
    }
}

#Preview {
    TransformView()
}

