//
//  AllRestaurantsView.swift
//  Restaurants
//
//  Created by DON on 11/8/22.
//

import SwiftUI

struct AllRestaurantsView: View {
    @ObservedObject var vm : AllRestaurantsViewModel
    var body: some View {
        NavigationView{
            ScrollView{
                ForEach(Array(vm.users), id: \.key) { key, value in
                    VStack{
                        NavigationLink{
                            ProfileDetailView(vm: ProfileDetailViewModel(userDetails: value))
//                            ProfileDetailView(userDetails: value, vm: ProfileDetailViewModel(uuid: key, lolat: value.lolat, lolon: value.lolon))
                        } label: {
                            ProfileCardView(userDetails: value)
                        }
                    }
                    Divider()
                        .padding()
                }
            }
            .navigationBarTitle("Restaurants")
            .navigationBarTitleDisplayMode(.inline)
            //.navigationViewStyle(StackNavigationViewStyle())
//            .navigationBarHidden(true)
            //.padding(.top, -200)
        }
        //.padding(.top, -90)
        .onAppear{
            vm.loadUsers()
//            vm.users["t"] = SessionUserDetails.parmishverma
//            vm.users["x"] = SessionUserDetails.parmishverma
        }
    }
}

struct AllRestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        AllRestaurantsView(vm: AllRestaurantsViewModel())
    }
}
