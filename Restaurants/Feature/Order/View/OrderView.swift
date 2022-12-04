//
//  SwiftUIView.swift
//  Restaurants
//
//  Created by DON on 11/11/22.
//

import SwiftUI

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

struct OrderView: View {
    @ObservedObject var vm : ProfileViewModel
    let order: Order
    let key: String
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
//                        print(order.id)
//                        print(key)
                        vm.markOrderComplete(orderId: order.id ?? "")
                        //vm.removeFromCart(itemID: item.id ?? "")
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.green)
                                .opacity(1)
                                .shadow(radius: 5)
                            Image(systemName: "checkmark")
                                .foregroundColor(.white)
                                .opacity(1)
                        }
                        .offset(x: 25, y: 0)
                    }
                }
                .padding(.vertical, -30)
                HStack{
                    Image(systemName: "person.fill")
                    Text("\(order.customerName)").fontWeight(.black)
                    Spacer()
                }
                .font(.title3)
                .opacity(0.9)
                Spacer()
                ForEach(order.cartItems){ cartitem in
                    VStack{
                        HStack{
                            Text("\(cartitem.quantity)x \(cartitem.dishname)").fontWeight(.black)
                            Spacer()
                        }
                        if cartitem.instructions != ""{
                            HStack{
                                Text("\"\(cartitem.instructions)\"")
                                Spacer()
                            }
                            .padding(.leading)
                        }
                    }
                    .font(.callout)
                }
                HStack{
                    Text("Ordered \(String(order.timestamp.timeAgoDisplay()))").font(.system(size: 12, weight: .bold, design: .monospaced))
                    Spacer()
                    Text("Total: $\(String(order.totalprice))").font(.system(size: 14, weight: .bold, design: .monospaced))
                }
                .font(.callout)
                .opacity(0.9)
                .padding(.top)
                
            }
            .padding()
            .background(.yellow)
            .opacity(0.7)

        }
        .padding(20)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(vm: ProfileViewModel(), order: .parmishverma, key: "")
    }
}
