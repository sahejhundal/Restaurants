//
//  RestaurantsApp.swift
//  Restaurants
//
//  Created by DON on 8/26/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      //FirebaseManager.shared.initializeUserDetails()

    return true
  }
}

@main
struct RestaurantsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var sessionService = SessionServiceImpl()
    @ObservedObject var profileViewModel = ProfileViewModel()
    @ObservedObject var allRestaurantsViewModel = AllRestaurantsViewModel()
    @ObservedObject var cartViewModel = CartViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                switch sessionService.state{
                case .loggedIn:
                    HomeView(profileViewModel: profileViewModel, allRestaurantsViewModel: allRestaurantsViewModel, cartViewModel: cartViewModel)
                        .environmentObject(sessionService)
                case .loggedOut:
                    LoginView()
                        .onAppear{
                            profileViewModel.clear()
                            allRestaurantsViewModel.clearUsers()
                            cartViewModel.clearCart()
                        }
                }
            }
        }
    }
}
