//
//  ProfileViewModel.swift
//  Restaurants
//
//  Created by DON on 10/26/22.
//

import Foundation
import CoreLocation
import MapKit

class AllRestaurantsViewModel: ObservableObject{
    @Published var users : [String: SessionUserDetails] = [:]
    
    func initialize(){
        self.loadUsers()
    }
    
    func clearUsers(){
        self.users = [:]
    }
    
    func loadUsers(){
        guard let userID = Restaurants.FirebaseManager.shared.auth.currentUser?.uid else{
            print("Not authenticated")
            return
        }
        Restaurants.FirebaseManager.shared.firestore.collection("users").whereField("isRestaurant", isEqualTo: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let data = document.data()
                        let id = document.documentID.description.description
                        if id == userID{
                            continue
                        }
                        let name = data["name"] as? String ?? ""
                        let email = data["email"] as? String ?? ""
                        let imageurl = data["imageurl"] as? String ?? ""
                        let phone = data["phone"] as? String ?? ""
                        let address = data["address"] as? String ?? ""
                        let city = data["city"] as? String ?? ""
                        let state = data["state"] as? String ?? ""
                        let customdescription = data["customdescription"] as? String ?? ""
                        let isRestaurant = data["isRestaurant"] as? Bool ?? false
                        let lolat = data["lolat"] as? Double ?? 0
                        let lolon = data["lolon"] as? Double ?? 0
                        let rating = data["rating"] as? Int ?? 0
                        let ratingcount = data["ratingcount"] as? Int ?? 0
                        DispatchQueue.main.async {
                            let userDetails = SessionUserDetails(id: id, name: name, email: email, imageurl: imageurl, phone: phone, address: address, city: city, state: state, customdescription: customdescription, rating: rating, ratingcount: ratingcount, isRestaurant: isRestaurant, lolat: lolat, lolon: lolon)
                            self.users[id] = userDetails
                        }
                    }
                }
        }
//        FirebaseManager.shared.firestore.collection("users").document(userID).collection("dishes").addSnapshotListener { querySnapshot, error in
//            guard let documents = querySnapshot?.documents else{
//                print("No documents")
//                return
//            }
//            print("Trying to populate dishes")
//            self.dishes = documents.compactMap { (queryDocumentSnapshot) -> Dish? in
//                print(queryDocumentSnapshot.data())
//                return try? queryDocumentSnapshot.data(as: Dish.self)
//            }
//        }
    }
}

