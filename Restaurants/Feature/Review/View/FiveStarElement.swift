//
//  FiveStarElement.swift
//  Restaurants
//
//  Created by DON on 11/12/22.
//

import SwiftUI

struct FiveStarElement: View {
    @Binding var rating: Int
    var body: some View {
        HStack(spacing: 20){
            if rating == 5{
                ForEach(1...5, id: \.self){i in
                    Button {
                        rating = i
                    } label: {
                        Image(systemName: "star.fill")
                    }
                }
            }
            else if rating>0{
                ForEach(1...Int(rating), id: \.self){i in
                    Button {
                        rating = i
                    } label: {
                        Image(systemName: "star.fill")
                    }
                }
                ForEach(Int(rating)+1...5, id: \.self){i in
                    Button {
                        rating = i
                    } label: {
                        Image(systemName: "star")
                    }
                }
            }
            else{
                ForEach(1...5-Int(rating), id: \.self){i in
                    Button {
                        rating = i
                    } label: {
                        Image(systemName: "star")
                    }
                }
            }
        }
        .font(.title)
        .foregroundColor(.orange)
        .frame(maxWidth: .infinity)
    }
}

struct FiveStarStaticElement: View {
    let rating: Int
    var body: some View {
        HStack(){
            if rating == 5{
                ForEach(1...5, id: \.self){i in
                    Image(systemName: "star.fill")
                }
            }
            else if rating>0{
                ForEach(1...Int(rating), id: \.self){i in
                    Image(systemName: "star.fill")
                }
                ForEach(Int(rating)+1...5, id: \.self){i in
                    Image(systemName: "star")
                }
            }
            else{
                ForEach(1...5-Int(rating), id: \.self){i in
                    Image(systemName: "star")
                }
            }
        }
        .font(.title)
        .foregroundColor(.orange)
        .scaledToFit()
    }
}

//struct FiveStarElement_Previews: PreviewProvider {
//    static var previews: some View {
//        FiveStarElement()
//    }
//}
