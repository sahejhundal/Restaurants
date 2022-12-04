//
//  DishRowView.swift
//  Restaurants
//
//  Created by DON on 8/26/22.
//

import SwiftUI

struct DishRowView: View {
    var dish: Dish
    var body: some View {
        VStack{
            VStack{
                HStack(){
                    if (dish.coverImage != nil) && dish.coverImage != ""{
                        AsyncImage(url: URL(string: dish.coverImage!)){ image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .border(Color.red.opacity(0))
                                .clipped()
                                .cornerRadius(10)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    Text(dish.name)
                        .font(.title2).bold()
                        .multilineTextAlignment(.leading)
                    Spacer()
                    Text("$" + String(dish.price)).font(.title2).bold()
                }//.padding(.horizontal)
                HStack(){
                    Text(dish.description)
                        .font(.caption)
                        .multilineTextAlignment(.leading)
                }.padding(.top, 1)
            }
            .padding()
            .background(.white)
            .shadow(radius: 15)
            .padding()
        }
        .foregroundColor(.black)
    }
}

struct DishRowView_Previews: PreviewProvider {
    static var previews: some View {
        DishRowView(dish: .butterchicken)
    }
}
