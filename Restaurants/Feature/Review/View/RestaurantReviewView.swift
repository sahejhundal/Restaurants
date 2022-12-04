//
//  RestaurantReview.swift
//  Restaurants
//
//  Created by DON on 11/12/22.
//

import SwiftUI

struct RestaurantReviewView: View {
    @Binding var review: RestaurantReviewModel
    var body: some View {
        VStack{
            if review.user != ""{
                VStack(spacing: 10){
                    FiveStarStaticElement(rating: review.rating)
                    let rtext = review.text ?? "NO REVIEW DATA"
                    let ftext = "\"" + rtext + "\""
                    Text(ftext).font(.system(size: 16, weight: .bold, design: .serif))
                }
                .padding(.bottom, 10)
            }
            else{
            FiveStarElement(rating: $review.rating)
            HStack{
                ZStack{
                    TextEditor(text: $review.text)
                        .font(.system(size: 22))
                        .frame(minWidth: 300, minHeight: 80, maxHeight: 100)
                    if review.text == ""{
                        Text("Write your review...")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    }
                }
//                Button {
//                    //
//                } label: {
//                    Image(systemName: "paperplane.fill")
//                        .font(.system(size: 30))
//                }
            }
            .shadow(radius: 5)
            .padding()
            }
        }
        
    }
}

//struct RestaurantReviewView: View {
//    @State var rating = 0
//    @State var text = ""
//    var review: RestaurantReviewModel? = .new
//    var body: some View {
//        VStack{
//            if review?.user != ""{
//                VStack(spacing: 10){
//                    FiveStarStaticElement(rating: review?.rating ?? 0)
//                    let rtext = review?.text ?? "NO REVIEW DATA"
//                    let ftext = "\"" + rtext + "\""
//                    Text(ftext).font(.system(size: 16, weight: .bold, design: .serif))
//                }
//            }
//            else{
//            FiveStarElement(rating: $rating)
//            HStack{
//                ZStack{
//                    TextEditor(text: $text)
//                        .font(.system(size: 22))
//                        .frame(minWidth: 300, minHeight: 80, maxHeight: 100)
//                    if text==""{
//                        Text("Write your review...")
//                            .foregroundColor(.gray)
//                            .opacity(0.5)
//                    }
//                }
//                Button {
//                    //
//                } label: {
//                    Image(systemName: "paperplane.fill")
//                        .font(.system(size: 30))
//                }
//            }
//            .shadow(radius: 5)
//            .padding()
//            }
//        }
//
//    }
//}

//struct RestaurantReviewView_Previews: PreviewProvider {
//    @State var review = RestaurantReviewModel.sample
//    static var previews: some View {
//        RestaurantReviewView(review: $review)
//    }
//}
