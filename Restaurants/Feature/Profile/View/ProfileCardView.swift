//
//  ProfileView.swift
//  Restaurants
//
//  Created by DON on 10/18/22.
//

import SwiftUI
import MapKit

struct ProfileCardView: View {
    let userDetails: SessionUserDetails
    
    func getColorforRating(rating: Double) -> Color{
        if rating == 0{ return .gray }
        else if rating <= 1{ return .red }
        else if rating <= 2{ return .orange }
        else if rating <= 3{ return .yellow }
        else if rating <= 4{ return .green }
        else{
            return .blue
        }
    }
    
    var body: some View {
        VStack {
            CircleImage(url: userDetails.imageurl.isEmpty ? "https://snworksceo.imgix.net/dtc/3f037af6-87ce-4a37-bb37-55b48029727d.sized-1000x1000.jpg?w=1000" : userDetails.imageurl)
                .padding(.top)

            VStack(alignment: .leading) {
                Text("\(userDetails.name=="" ? "Name" : userDetails.name)")
                    .font(.title).bold()

                HStack {
                    Text("\(userDetails.address=="" ? "Address" : userDetails.address), \(userDetails.city=="" ? "City" : userDetails.city)")
                    Spacer()
                    Text("\(userDetails.state=="" ? "State" : userDetails.state)").bold()
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                
                HStack {
                    Text("\(userDetails.phone=="" ? "Phone" : userDetails.phone)")
                        .font(.title3)
                    Spacer()
                    let rating = Double((userDetails.rating ?? 0)) / Double((userDetails.ratingcount ?? 0))
                    HStack(spacing: 0) {
                        Image(systemName: "star.fill")
                            .foregroundColor(getColorforRating(rating: rating))
                            .shadow(color: .blue, radius: rating == 5 ? 5 : 0)
                        Text("(\(String(rating)))")
                    }
                }
                Text("\(userDetails.customdescription=="" ? "Description goes here" : userDetails.customdescription)")
                    .font(.caption)
            }
            .padding()
        }
        .background()
        .padding()
        .shadow(radius: 5)
        .foregroundColor(.black)
    }
}

struct ProfileCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView{
            ProfileCardView(userDetails: .parmishverma)
            Divider()
                .padding()
            ProfileCardView(userDetails: .parmishverma)
        }
        
    }
}
