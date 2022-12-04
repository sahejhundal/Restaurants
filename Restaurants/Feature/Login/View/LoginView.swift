//
//  LoginView.swift
//  Restaurants
//
//  Created by DON on 10/17/22.
//

import SwiftUI

struct LoginView: View {
    @StateObject var vm = LoginViewModelImpl(service: LoginServiceImpl())
    @State var showRegistration: Bool = false
    @State var showForgotPassword: Bool = false
    var body: some View {
        VStack{
            InputTextField(text: $vm.credentials.email, placeholder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope")
                
            PasswordField(text: $vm.credentials.password, placeholder: "Password", sfSymbol: "key")
            
            HStack{
                Spacer()
                Button {
                    showForgotPassword.toggle()
                } label: {
                    Text("Forgot Password")
                }
                .sheet(isPresented: $showForgotPassword) {
                    ForgotPasswordView()
                }
            }
            
            VStack(spacing: 16){
                ButtonComponentView(title: "Login") {
                    vm.login()
                }
                ButtonComponentView(title: "Sign Up",background: .clear,foreground: .blue) {
                    showRegistration.toggle()
                }
                .sheet(isPresented: $showRegistration) {
                    SignUpView()
                }
            }
        }
        .padding(.horizontal)
        .navigationTitle("Login")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            LoginView()
        }
    }
}
