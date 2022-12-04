//
//  EditUserProfile.swift
//  Restaurants
//
//  Created by DON on 10/18/22.
//

import SwiftUI

struct EditUserView: View {
    @StateObject var profilevm: ProfileViewModel
    
    @StateObject var vm = EditUserViewModel()
    
    var body: some View {
        NavigationView{
            ZStack{
                ScrollView{
                    VStack(spacing: 32){
                        VStack(spacing: 16){
                            Toggle("I AM A RESTAURANT", isOn: $vm.userDetails.isRestaurant)
                            InputTextField(text: $vm.userDetails.name, placeholder: "Name", keyboardType: .namePhonePad, sfSymbol: "person")
                            InputTextField(text: $vm.userDetails.customdescription, placeholder: "Custom Description", keyboardType: .emailAddress, sfSymbol: "note")
                            HStack{
                                InputTextField(text: $vm.userDetails.imageurl, placeholder: "Image URL", keyboardType: .URL, sfSymbol: "photo")
                                ImagePickerView(selectedImage: $vm.image)
                            }
                            
                            InputTextField(text: $vm.userDetails.phone, placeholder: "Phone", keyboardType: .phonePad, sfSymbol: "phone")
                            InputTextField(text: $vm.userDetails.email, placeholder: "Email", keyboardType: .emailAddress, sfSymbol: "envelope")
                            InputTextField(text: $vm.userDetails.address, placeholder: "Address", keyboardType: .default, sfSymbol: "house")
                            InputTextField(text: $vm.userDetails.city, placeholder: "City", keyboardType: .default, sfSymbol: "building.2")
                            InputTextField(text: $vm.userDetails.state, placeholder: "State", keyboardType: .default, sfSymbol: "flag")
                        }
                        
                        VStack(spacing: 16){
                            ButtonComponentView(title: "Update Profile") {
                                Task{
                                    await vm.makeEdits()
//                                    if await vm.makeEdits(){
//                                        profilevm.showProfileEditor = false
//                                        loading = false
//                                    }
                                    //profilevm.showProfileEditor.toggle()
                                }
                            }
                            .frame(minHeight: 50)
                        }
                    }
                    .padding(.horizontal)
                    .navigationTitle("Profile Editor")
                    .applyClose()
                }
                if vm.loading == true{
                    ZStack{
                        Rectangle().foregroundColor(.gray).frame(width: 1000, height: 1000).opacity(0.5)
                        ProgressView()
                    }
                }
            }
            
        }
        
    }
}

struct EditUserView_Previews: PreviewProvider {
    static var previews: some View {
        EditUserView(profilevm: ProfileViewModel())
    }
}
