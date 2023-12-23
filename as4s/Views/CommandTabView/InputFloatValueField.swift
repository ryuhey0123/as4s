//
//  InputFloatValueField.swift
//  as4s
//
//  Created by Ryuhei Fujita on 2023/12/22.
//

import SwiftUI

struct InputFloatValueField: View {
    @Binding var value: Float?
    var label: String = ""
    var systemImage: String = "number.square.fill"
    var unit: String = ""
    var pronpt: Text?
    
    var body: some View {
        HStack {
            TextField(value: $value, format: .number, prompt: pronpt) {
                HStack {
                    Text(label)
                        .frame(width: 35, alignment: .trailing)
                    Image(systemName: systemImage)
                }
            }
            .multilineTextAlignment(.trailing)
            Text(unit)
                .font(.footnote)
        }
        .frame(height: 19)
    }
}

struct InputIntValueField: View {
    @Binding var value: Int?
    var label: String = ""
    var systemImage: String = "1.square.fill"
    var unit: String = ""
    var pronpt: Text?
    
    var body: some View {
        HStack {
            TextField(value: $value, format: .number, prompt: pronpt) {
                HStack {
                    Text(label)
                        .frame(width: 35, alignment: .trailing)
                    Image(systemName: systemImage)
                }
            }
            .multilineTextAlignment(.trailing)
            Text(unit)
                .font(.footnote)
        }
        .frame(height: 19)
    }
}


#Preview {
    InputFloatValueField(value: .constant(2392))
}
