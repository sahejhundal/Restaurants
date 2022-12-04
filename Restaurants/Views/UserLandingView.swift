//
//  UserLandingView.swift
//  Restaurants
//
//  Created by DON on 8/26/22.
//

import SwiftUI

struct UserLandingView: View {
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                Text("Add")
                Spacer()
                Text("Restaurant Menu")
                Spacer()
                Text("Edit")
            }.padding()
            List {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Content")/*@END_MENU_TOKEN@*/
            }
        }
    }
}

struct UserLandingView_Previews: PreviewProvider {
    static var previews: some View {
        UserLandingView()
    }
}
