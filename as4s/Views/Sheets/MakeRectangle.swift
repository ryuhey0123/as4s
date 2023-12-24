//
//  MakeRectangle.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/24.
//

import SwiftUI

struct MakeRectangle: View {
    let labelWidth: CGFloat = 50
    
    @State private var id: Int?
    @State private var label: String = ""
    @State private var width: Float?
    @State private var height: Float?
    
    var body: some View {
        VStack {
            Text("Rectangle Shape")
                .font(.headline)
            Image(systemName: "rectangle.portrait.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.secondary)
                .frame(width: 70.0, height: 70.0)
                .padding()
            Form {
                InputIntValueField(value: $id, label: "ID", labelWidth: labelWidth)
                InputStringValueField(value: $label, label: "Label", labelWidth: labelWidth)
                InputFloatValueField(value: $width, label: "Width", labelWidth: labelWidth)
                InputFloatValueField(value: $height, label: "Height", labelWidth: labelWidth)
            }
            SubmitButtom(cancelAction: {
                
            }, submitAction: {
                
            })
        }
    }
}

#Preview {
    MakeRectangle()
}
