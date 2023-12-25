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
    var labelWidth: CGFloat = 25
    
    var body: some View {
        HStack {
            TextField(value: $value, format: .number, prompt: pronpt) {
                HStack {
                    Text(label)
                        .frame(width: labelWidth, alignment: .trailing)
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
    var labelWidth: CGFloat = 25
    
    var body: some View {
        HStack {
            TextField(value: $value, format: .number, prompt: pronpt) {
                HStack {
                    Text(label)
                        .frame(width: labelWidth, alignment: .trailing)
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

struct InputIntValuesField: View {
    @Binding var array: [Int]
    @State private var string: String = ""
    
    var label: String = ""
    var systemImage: String = "1.square.fill"
    var unit: String = ""
    var pronpt: Text?
    var labelWidth: CGFloat = 25
    
    var body: some View {
        HStack {
            TextField(text: $string, prompt: pronpt) {
                HStack {
                    Text(label)
                        .frame(width: labelWidth, alignment: .trailing)
                    Image(systemName: systemImage)
                }
            }
            .multilineTextAlignment(.trailing)
            .onChange(of: string) {
                array = string.components(separatedBy: ",")
                    .compactMap { Int($0.trimmingCharacters(in: .whitespacesAndNewlines)) }
            }
            .onChange(of: array) {
                string = ""
                if !array.isEmpty {
                    array[0..<array.endIndex-1].forEach {
                        string += "\($0), "
                    }
                    string += "\(array.last!)"
                }
            }
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
    var labelWidth: CGFloat = 25
    
    var body: some View {
        HStack {
            TextField(text: $value) {
                HStack {
                    Text(label)
                        .frame(width: labelWidth, alignment: .trailing)
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
            .border(.secondary)
        InputIntValueField(value: .constant(23))
            .border(.secondary)
        InputStringValueField(value: .constant("Test Label"))
            .border(.secondary)
        InputIntValuesField(array: .constant([1, 2, 3]))
            .border(.secondary)
    }
    .padding()
    .frame(width: 300)
}
