//
//  P2.swift
//  Restaurants
//
//  Created by DON on 12/2/22.
//

import SwiftUI

struct P2: View {
    @State var sizeQ: CGFloat = 120
    let review = DishReviewModel(dishId: "", restaurantId: "", dishname: "Butter Chicken", user: "", userName: "choppa", rating: 4, text: "ight", imageurl: "https://firebasestorage.googleapis.com:443/v0/b/restaurants-b2a42.appspot.com/o/images%2Fdishes%2FnnANL1ENKZuMfI7185id%2Fbp9ts7R6H9dbswIzzTycjFnA6Lt2?alt=media&token=de9daaa4-8188-4023-bd16-669610490f2e")
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
                        if sizeQ == 120{
                            sizeQ = 400
                        } else{
                            sizeQ = 120
                        }
                    }
                }
            }
            if sizeQ == 120{
                VStack(spacing: 10){
                    FiveStarStaticElement(rating: review.rating)
                    let ftext = "\"" + review.text + "\""
                    Text(ftext).font(.system(size: 16, weight: .bold, design: .serif))
                    Text("-\(review.userName)")
                }
            }
        }
        .padding(.horizontal)
        
    }
}

struct P2_Previews: PreviewProvider {
    static var previews: some View {
        P2()
    }
}
