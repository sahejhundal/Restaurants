//
//  CartItemView.swift
//  Restaurants
//
//  Created by DON on 11/10/22.
//

import SwiftUI

struct CartItemView: View {
    @ObservedObject var vm : CartViewModel
    let item: CartItem
    var body: some View {
        ZStack{
            Rectangle()
                .foregroundColor(.white)
                .frame(minHeight: 100)
                .shadow(radius: 10)
            VStack(spacing: 0){
                HStack{
                    Spacer()
                    Button {
                        vm.removeFromCart(itemID: item.id ?? "")
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.red)
                                .opacity(0.8)
                                .shadow(radius: 5)
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .opacity(0.7)
                        }
                        .offset(x: 25, y: 0)
                    }
                }
                .padding(.vertical, -30)
                HStack{
                    Text("\(item.dishname) from \(item.restaurantName)").fontWeight(.black)
                    Spacer()
                }
                .font(.title3)
                .opacity(0.9)
                Spacer()
                HStack{
                    Text("Price: $\(String(item.price))").fontWeight(.bold)
                    Spacer()
                    Text("Qty: \(String(item.quantity))").fontWeight(.bold)
                }
                .font(.caption)
                .opacity(0.5)
                HStack{
                    Text("Special Instructions: \"\(item.instructions)\"")
                        .fontWeight(.medium).opacity(0.5)
                    Spacer()
                }
                .font(.caption)
                
            }
            .padding()

        }
        .padding(20)
    }
}

struct CartItemView_Previews: PreviewProvider {
    static var previews: some View {
        CartItemView(vm: CartViewModel(), item: CartItem.new)
    }
}
