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

struct InputStringValueField: View {
    @Binding var value: String
    var label: String = ""
    var systemImage: String = "s.square.fill"
    var unit: String = ""
    var pronpt: Text?
    
    var body: some View {
        HStack {
            TextField(text: $value) {
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
    Form {
        InputFloatValueField(value: .constant(2392.0923))
        InputIntValueField(value: .constant(23))
        InputStringValueField(value: .constant("Test Label"))
    }
}
