//
//  ProfileTab.swift
//  Restaurants
//
//  Created by DON on 11/2/22.
//

import SwiftUI

struct ProfileTab: View {
    @EnvironmentObject var sessionService: SessionServiceImpl
    @StateObject var vm : ProfileViewModel
    @ObservedObject var menuvm: AddDishViewModel
    
    var body: some View {
        NavigationView{
            ScrollView {
                ProfileView(vm: vm)
                
                if !vm.orders.isEmpty{
                    VStack{
                        Text("Orders For You").font(.system(.title)).fontWeight(.bold)
    //                    OrderView(vm: vm, order: .parmishverma)
                        ForEach(Array(vm.orders), id: \.key) { key, order in
                            OrderView(vm: vm, order: order, key: key)
                        }
                    }
                }
                
                
                DishListView(dishes: vm.dishes)
                
                VStack {
                    ButtonComponentView(title: "Profile Editor",background: .clear,foreground: .blue, border: .blue) {
                                vm.showProfileEditor.toggle()
                    }.frame(height: 50)
                    
                    ButtonComponentView(title: "Menu Builder", background: .clear, foreground: .blue, border: .blue) {
                        menuvm.showMenuBuilder.toggle()
                    }.frame(height: 50)

                    ButtonComponentView(title: "Logout", background: .red, border: .red) {
                        sessionService.logout()
                    }.frame(height: 50)

                    .sheet(isPresented: $vm.showProfileEditor) {

                        EditUserView(profilevm: vm)
                    }
 
                    .sheet(isPresented: $menuvm.showMenuBuilder) {
                        AddDishView(vm: menuvm)
                    }
                }
                .padding()

            }
            .ignoresSafeArea(edges: .top)
            //.navigationBarHidden(true)
        }
        
        .onAppear{
            vm.initialize()
        }
    }
}

struct ProfileTab_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTab(vm: ProfileViewModel(),menuvm: AddDishViewModel())
    }
}
