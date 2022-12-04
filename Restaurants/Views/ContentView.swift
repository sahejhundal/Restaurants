//
//  ContentView.swift
//  Restaurants
//
//  Created by DON on 8/26/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

//struct ContentView: View {
//    var body: some View {
//        VStack(){
//            NavigationView{
//                VStack(){
//                    HStack(){
//                        Spacer()
//                        NavigationLink{
//                            AddDishView()
//                        } label: {
//                            Text("Add")
//                        }
//                    }
//                    Spacer()
//                }
//            }
//            DishListView()
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
