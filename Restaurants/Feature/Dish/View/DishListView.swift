//
//  DishListView.swift
//  Restaurants
//
//  Created by DON on 8/27/22.
//

import SwiftUI

struct DishListView: View {
    let dishes: [String: Dish]
    var body: some View {
        VStack{
            if dishes.isEmpty{
                Text("Empty Menu").font(.system(.title)).fontWeight(.bold)
            } else{
                Text("Our Menu").font(.system(.title)).fontWeight(.bold)
                ForEach(Array(dishes), id: \.key) { key, d in
                    VStack{
                        NavigationLink{
                            DishDetailView(vm: DishDetailViewModel(dish: d))
                        } label: {
                            DishRowView(dish: d)
                        }
                    }
                }
            }
        }
//        NavigationView{
//            List {
                
//            }
//            .navigationTitle("Menu")
//        }
    }
}
//
//struct DishListView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView{
//            ScrollView{
//                ProfileView(vm: ProfileViewModel())
//                DishListView(dishes: [Dish(
//                    id: "test",
//                    codename: "test",
//                    name: "test",
//                    description: "test dish",
//                    price: "5"
//                ),Dish(
//                    id: "test",
//                    codename: "test",
//                    name: "test",
//                    description: "test dish",
//                    price: "5"
//                )])
//                Text("SAHEJ")
//            }
//        }
//        
//    }
//}
