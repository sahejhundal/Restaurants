//
//  ProfileView.swift
//  Restaurants
//
//  Created by DON on 10/18/22.
//

import SwiftUI
import MapKit

struct ProfileView: View {
    @ObservedObject var vm: ProfileViewModel
    
    @State var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: FirebaseManager.shared.userDetails.lolat, longitude: FirebaseManager.shared.userDetails.lolon),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
                .ignoresSafeArea(edges: .top)
                .frame(height: 350)
            
            CircleImage(url: FirebaseManager.shared.userDetails.imageurl.isEmpty ? "https://snworksceo.imgix.net/dtc/3f037af6-87ce-4a37-bb37-55b48029727d.sized-1000x1000.jpg?w=1000" : FirebaseManager.shared.userDetails.imageurl)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {
                Text("\(FirebaseManager.shared.userDetails.name=="" ? "Name" : FirebaseManager.shared.userDetails.name)")
                    .font(.title)

                HStack {
                    Text("\(FirebaseManager.shared.userDetails.address=="" ? "Address" : FirebaseManager.shared.userDetails.address), \(FirebaseManager.shared.userDetails.city=="" ? "City" : FirebaseManager.shared.userDetails.city)")
                    Spacer()
                    Text("\(FirebaseManager.shared.userDetails.state=="" ? "State" : FirebaseManager.shared.userDetails.state)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)

                Divider()

                Text("\(FirebaseManager.shared.userDetails.phone=="" ? "Phone" : FirebaseManager.shared.userDetails.phone)")
                    .font(.title3)
                Text("\(FirebaseManager.shared.userDetails.customdescription=="" ? "Description goes here" : FirebaseManager.shared.userDetails.customdescription)")
                    .font(.caption)
            }
            .padding()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: ProfileViewModel())
    }
}
