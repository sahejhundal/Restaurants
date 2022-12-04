//
//  ProfileViewModel.swift
//  Restaurants
//
//  Created by DON on 10/26/22.
//

import Foundation
import CoreLocation
import MapKit

class ProfileDetailViewModel: ObservableObject{
    @Published var showProfileEditor: Bool = false
    @Published var showMenuBuilder: Bool = false
    //@Published var userDetails = SessionUserDetails.new
    @Published var review : RestaurantReviewModel = .new
    @Published var dishes : [String: Dish] = [:]
    @Published var region: MKCoordinateRegion
    @Published var userDetails: SessionUserDetails
    init(userDetails: SessionUserDetails){
        self.userDetails = userDetails
        self.uuid = userDetails.id ?? ""
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: userDetails.lolat, longitude: userDetails.lolon),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    }
    var uuid: String
//    @Published var region = MKCoordinateRegion(
//        center: CLLocationCoordinate2D(latitude: FirebaseManager.shared.userDetails.lolat, longitude: FirebaseManager.shared.userDetails.lolon),
//            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    )
    
//    init(uuid: String, lolat: Double, lolon: Double){
//        self.uuid = uuid
//        self.region = MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: lolat, longitude: lolon),
//                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//        )
//    }
    
    func getReview() async{
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let docRef = FirebaseManager.shared.firestore.collection("users").document(uuid).collection("reviews").document(userID)
        do{
            if try await docRef.getDocument().exists{
                docRef.getDocument(as: RestaurantReviewModel.self){ result in
                    switch result {
                    case .success(let review):
                        DispatchQueue.main.async {
                            self.review = review
                            print("Found review \(review)")
                        }
                    case .failure(let error):
                        print("Error decoding restaurant: \(error)")
                    }
                }
            }
        } catch{
            return
        }
    }
    
    func addReview(){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        do{
            review.id = userID
            review.user = userID
            review.userName = FirebaseManager.shared.userDetails.name == "" ? "Unknown" : FirebaseManager.shared.userDetails.name
            let docRef = FirebaseManager.shared.firestore.collection("users").document(uuid)
            try docRef.collection("reviews").document(userID).setData(from: review)
//            try docRef.collection("reviews").addDocument(from: review){ err in
//                if let err = err {
//                    print("Error adding review: \(err)")
//                } else {
//                    print("Review added!")
//                }
//            }
            docRef.updateData(["rating": (userDetails.rating ?? 0) + review.rating, "ratingcount": (userDetails.ratingcount ?? 0) + 1]){ err in
                if let err = err {
                    print("Error updating user ratings: \(err)")
                } else {
                    print("User ratings updated!")
                }
            }
        } catch{
            print(error)
        }
    }
    
    func loadDishes(){
        guard let userID = Restaurants.FirebaseManager.shared.auth.currentUser?.uid else{
            print("Not authenticated")
            return
        }
        FirebaseManager.shared.firestore.collection("users").document(uuid).collection("dishes").getDocuments() { (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else{
                print("No documents")
                return
            }
            print("Trying to populate dishes")
            let dishes = documents.compactMap { (queryDocumentSnapshot) -> Dish? in
//                print(queryDocumentSnapshot.data())
                return try? queryDocumentSnapshot.data(as: Dish.self)
            }
            DispatchQueue.main.async {
                for di in dishes{
                    self.dishes[di.id ?? "nodishid"] = di
                }
            }
        }
        return
    }
    
    /*
    func loaddDishes(){
        guard let userID = Restaurants.FirebaseManager.shared.auth.currentUser?.uid else{
            print("Not authenticated")
            return
        }
        let docRef = Restaurants.FirebaseManager.shared.firestore.collection("users").document(self.uuid)
        docRef.collection("dishes").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = document.documentID.description.description
                    let name = data["name"] as? String ?? ""
                    let codename = data["codename"] as? String ?? ""
                    let description = data["description"] as? String ?? ""
                    let price = data["price"] as? Double ?? 0
                    let restaurantName = data["restaurantName"] as? String ?? ""
                    let restaurantID = data["restaurantID"] as? String ?? ""
                    let coverImage = data["coverImage"] as? String ?? ""
                    let dish = Dish(id: id, codename: codename, name: name, description: description, price: price, restaurantName: restaurantName, restaurantID: restaurantID, coverImage: coverImage)
                    print("dish is ready", dish)
                    DispatchQueue.main.async {
                        self.dishes[id] = dish
                        print("model dishes are ")
                        print(self.dishes)
                    }
                }
                return
            }
        }
        docRef.collection("reviews").document(userID).getDocument(as: RestaurantReviewModel.self) { result in
            switch result {
            case .success(let review):
                DispatchQueue.main.async {
                    self.review = review
                }
            case .failure(let error):
                print("Error decoding city: \(error)")
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
     */
}

