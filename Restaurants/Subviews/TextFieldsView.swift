//
//  TextFields.swift
//  Restaurants
//
//  Created by DON on 10/17/22.
//

import SwiftUI

struct InputTextEditor: View{
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View{
        ZStack(alignment: .leading){
            TextEditor(text: $text)
                .frame(minHeight: 80)
                //.frame(maxWidth: .infinity,
                //minHeight: 44)
                .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
                .keyboardType(keyboardType)
                .background(
                    ZStack(alignment: .leading){
                        if let systemImage = sfSymbol{
                            Image(systemName: systemImage)
                                .font(.system(size: 16, weight: .semibold))
                                .padding(.leading,5)
                                .foregroundColor(Color.gray.opacity(0.5))
                        }
                        RoundedRectangle(cornerRadius: 10,style: .continuous)
                            .stroke(Color.gray.opacity(0.25))
                    }
                )
            if text.isEmpty{
                Text(placeholder)
                    .padding(.horizontal, 30)
                    .foregroundColor(.gray)
                    .opacity(0.5)
            }
        }
    }
}

struct InputFloatField: View{
    @Binding var text: Double
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View{
        TextField(placeholder, value: $text, format: .number)
            .frame(maxWidth: .infinity,
            minHeight: 44)
            .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
            .keyboardType(keyboardType)
            .background(
                ZStack(alignment: .leading){
                    if let systemImage = sfSymbol{
                        Image(systemName: systemImage)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.leading,5)
                            .foregroundColor(Color.gray.opacity(0.5))
                    }
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .stroke(Color.gray.opacity(0.25))
                }
            )
    }
}

struct InputIntField: View{
    @Binding var text: Int
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol  = ""
        return formatter
    }()
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View{
        TextField(placeholder, value: $text, formatter: numberFormatter)
            .frame(maxWidth: .infinity,
            minHeight: 44)
            .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
            .keyboardType(keyboardType)
            .background(
                ZStack(alignment: .leading){
                    if let systemImage = sfSymbol{
                        Image(systemName: systemImage)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.leading,5)
                            .foregroundColor(Color.gray.opacity(0.5))
                    }
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .stroke(Color.gray.opacity(0.25))
                }
            )
    }
}

struct InputTextField: View{
    @Binding var text: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    let sfSymbol: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View{
        TextField(placeholder, text: $text)
            .frame(maxWidth: .infinity,
            minHeight: 44)
            .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
            .keyboardType(keyboardType)
            .background(
                ZStack(alignment: .leading){
                    if let systemImage = sfSymbol{
                        Image(systemName: systemImage)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.leading,5)
                            .foregroundColor(Color.gray.opacity(0.5))
                    }
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .stroke(Color.gray.opacity(0.25))
                }
            )
        
    }
}

struct PasswordField: View{
    @Binding var text: String
    let placeholder: String
    let sfSymbol: String?
    
    private let textFieldLeading: CGFloat = 30
    
    var body: some View{
        SecureField(placeholder, text: $text)
            .frame(maxWidth: .infinity,
            minHeight: 44)
            .padding(.leading, sfSymbol == nil ? textFieldLeading / 2 : textFieldLeading)
            .background(
                ZStack(alignment: .leading){
                    if let systemImage = sfSymbol{
                        Image(systemName: systemImage)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.leading,5)
                            .foregroundColor(Color.gray.opacity(0.5))
                    }
                    RoundedRectangle(cornerRadius: 10,style: .continuous)
                        .stroke(Color.gray.opacity(0.25))
                }
            )
        
    }
}

struct TextFields: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TextFields_Previews: PreviewProvider {
    static var previews: some View {
        TextFields()
    }
}
