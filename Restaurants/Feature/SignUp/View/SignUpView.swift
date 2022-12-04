//
//  SignUpView.swift
//  Restaurants
//
//  Created by DON on 10/17/22.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var vm = SignUpViewModelImpl(service: SignUpServiceImpl())
    @State var email: String = ""
    @State var password: String = ""
    var body: some View {
        NavigationView{
            VStack(spacing: 32){
                VStack(spacing: 16){
                    InputTextField(text: $vm.userDetails.name, placeholder: "Name", keyboardType: .namePhonePad, sfSymbol: "person")
                    
                    InputTextField(text: $vm.userDetails.email, placeholder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope")
                        
                    PasswordField(text: $vm.userDetails.password, placeholder: "Password", sfSymbol: "key")
                }
                
                VStack(spacing: 16){
                    ButtonComponentView(title: "Sign Up") {
                        vm.signup()
                    }
//                    ButtonComponentView(title: "Login",background: .clear,foreground: .blue,border: .blue) {
//                        //TODO
//                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Register")
            .applyClose()
        }
        
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
