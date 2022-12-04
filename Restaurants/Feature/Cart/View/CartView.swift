//
//  CartView.swift
//  Restaurants
//
//  Created by DON on 11/10/22.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var vm : CartViewModel
    var body: some View {
        NavigationView{
            ZStack{
                if vm.cartItems.isEmpty{
                    VStack{
                        Image(systemName: "cart").font(.system(size: 100))
                        Text("Empty Cart").font(.system(size: 30))
                    }
                    .foregroundColor(.gray)
                    .opacity(0.7)
                    .offset(y:-40)
                }
                VStack{
                    ScrollView{
                        ForEach(Array(vm.cartItems), id: \.key) { key, item in
                            CartItemView(vm: vm, item: item)
                        }
                    }
                    
                    if vm.total != 0{
                        HStack{
                            Spacer()
                            Text("Total: $\(String(vm.total))").foregroundColor(.white).font(.system(size: 16,weight: .bold,design: .monospaced)).padding(.horizontal,5).padding(.vertical,1).background(.black)
                        }
                        .padding(.horizontal)
                    }
                    ButtonComponentView(title: "Checkout",
                                        background: vm.cartItems.isEmpty ? .gray : .yellow.opacity(0.7),
                                        foreground: .black,
                                        border: .clear) {
                        vm.submitOrder()
                    }
                                        .padding()
                    
                }
                .onAppear{
                    vm.loadCartItems()
                }
            }
            
            
            .navigationTitle("Your Order")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(vm: CartViewModel())
    }
}
