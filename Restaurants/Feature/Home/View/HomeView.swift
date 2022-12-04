//
//  HomeView.swift
//  Restaurants
//
//  Created by DON on 10/17/22.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    
    let dummyDetails = SessionUserDetails.new
    @ObservedObject var profileViewModel : ProfileViewModel
    @ObservedObject var allRestaurantsViewModel : AllRestaurantsViewModel
    @ObservedObject var cartViewModel : CartViewModel
    
    var body: some View {
        TabView{
            AllRestaurantsView(vm: allRestaurantsViewModel)
                .tabItem {
                    Label("Feed", systemImage: "fork.knife")
                }
            CartView(vm: cartViewModel)
                .environmentObject(sessionService)
                .tabItem {
                    Label("Cart", systemImage: "cart.fill")
                }
            ProfileTab(vm: profileViewModel, menuvm: AddDishViewModel())
                .environmentObject(sessionService)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(profileViewModel: ProfileViewModel(), allRestaurantsViewModel: AllRestaurantsViewModel(), cartViewModel: CartViewModel())
            .environmentObject(SessionServiceImpl())
    }
}
