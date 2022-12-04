//
//  StaticDishReviewView.swift
//  Restaurants
//
//  Created by DON on 12/2/22.
//

import SwiftUI

struct StaticDishReviewView: View {
    let ogSize: CGFloat = 120
    @State var sizeQ: CGFloat = 120
    let review: DishReviewModel
    var body: some View {
        HStack{
            if review.imageurl != ""{
                AsyncImage(url: URL(string: review.imageurl)){ image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .aspectRatio(contentMode: .fill)
                .frame(width: sizeQ, height: sizeQ)
                .border(Color.red.opacity(0))
                .clipped()
                .cornerRadius(10)
                .onTapGesture {
                    withAnimation {
                        if sizeQ == ogSize{
                            sizeQ = 300
                        } else{
                            sizeQ = ogSize
                        }
                    }
                }
            }
            if sizeQ == ogSize{
                VStack(spacing: 10){
                    FiveStarStaticElement(rating: review.rating)
                    let ftext = "\"" + review.text + "\""
                    Text(ftext).font(.system(size: 16, weight: .bold, design: .serif))
                    Text("-\(review.userName)")
                }
            }
        }
    }
}

struct StaticDishReviewView_Previews: PreviewProvider {
    static var previews: some View {
        StaticDishReviewView(review: .new)
    }
}
