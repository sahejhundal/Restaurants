//
//  ButtonView.swift
//  Restaurants
//
//  Created by DON on 10/17/22.
//

import SwiftUI

struct ButtonComponentView: View{
    typealias ActionHandler = () -> Void
    let title: String
    let background: Color
    let foreground: Color
    let border: Color
    let handler: ActionHandler
    
    private let cornerRadius: CGFloat = 10
    
    internal init(title: String,
                  background: Color = .blue,
                  foreground: Color = .white,
                  border: Color = .clear,
                  handler: @escaping ButtonComponentView.ActionHandler){
        self.title=title
        self.background=background
        self.foreground=foreground
        self.border=border
        self.handler=handler
    }
    
    var body: some View{
        Button(action: handler) {
            Text(title)
//                .frame(width: .infinity, height: 50)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(background)
                .foregroundColor(foreground)
                .font(.system(size: 16,weight: .bold))
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(border,lineWidth: 2)
                )
        }
    }
}

struct ButtonView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView()
    }
}
