//
//  ProfileView.swift
//  Restaurants
//
//  Created by DON on 10/18/22.
//

import SwiftUI
import MapKit

struct ProfileDetailView: View {
    //let userDetails: SessionUserDetails
    @StateObject var vm: ProfileDetailViewModel
    
    var body: some View {
        ScrollView {
            Map(coordinateRegion: $vm.region)
                .ignoresSafeArea(edges: .top)
                .frame(height:250)
            
            CircleImage(url: vm.userDetails.imageurl.isEmpty ? "https://snworksceo.imgix.net/dtc/3f037af6-87ce-4a37-bb37-55b48029727d.sized-1000x1000.jpg?w=1000" : vm.userDetails.imageurl)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                Text("\(vm.userDetails.name=="" ? "Name" : vm.userDetails.name)")
                    .font(.title)

                HStack {
                    Text("\(vm.userDetails.address=="" ? "Address" : vm.userDetails.address), \(vm.userDetails.city=="" ? "City" : vm.userDetails.city)")
                    Spacer()
                    Text("\(vm.userDetails.state=="" ? "State" : vm.userDetails.state)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()
                Button(action: {
                    let phone = "tel://"
                    let phoneNumberformatted = phone + vm.userDetails.phone
                    guard let url = URL(string: phoneNumberformatted) else { return }
                    UIApplication.shared.open(url)
                   }) {
                       Text("\(vm.userDetails.phone=="" ? "Phone" : vm.userDetails.phone)")
                           .font(.title3).foregroundColor(.blue)
                }
                Text("\(vm.userDetails.customdescription=="" ? "Description goes here" : vm.userDetails.customdescription)")
                    .font(.caption)
            }
            .padding()
            
            VStack{
                RestaurantReviewView(review: $vm.review)
                if vm.review.text != "" && vm.review.user == ""{
                    ButtonComponentView(title: "Submit") {
                        // Submit review
                        vm.addReview()
                        print("SLATT")
                    }
                    .frame(minHeight: 40)
                    .padding()
                }
            }
            
            
            DishListView(dishes: vm.dishes)
        }
//        .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .edgesIgnoringSafeArea(.top)
        .onAppear{
            vm.loadDishes()
            Task{
                await vm.getReview()
            }
        }
    }
}

struct ProfileDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetailView(vm: ProfileDetailViewModel(userDetails: .parmishverma))
        //ProfileDetailView(userDetails: .parmishverma , vm: ProfileDetailViewModel(uuid: "bp9ts7R6H9dbswIzzTycjFnA6Lt2", lolat: 37.5343541, lolon: -121.9668728))
    }
}
