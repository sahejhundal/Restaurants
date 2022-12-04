//
//  ForgotPasswordView.swift
//  Restaurants
//
//  Created by DON on 10/17/22.
//

import SwiftUI

struct ForgotPasswordView: View {
    @State var email: String = ""
    var body: some View {
        NavigationView{
            VStack{
                InputTextField(text: $email, placeholder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope")
                
                VStack(spacing: 16){
                    ButtonComponentView(title: "Send Reset Link") {
                        //TODO
                    }
//                    ButtonComponentView(title: "Back to Login",background: .clear,foreground: .blue) {
//                        //TODO
//                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Forgot Password?")
            .applyClose()
        }
        
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
