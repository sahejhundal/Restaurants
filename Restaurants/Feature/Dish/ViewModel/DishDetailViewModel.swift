//
//  ProfileViewModel.swift
//  Restaurants
//
//  Created by DON on 10/26/22.
//

import Foundation
import CoreLocation
import MapKit

class DishDetailViewModel: ObservableObject{
    @Published var quantity: Int = 1
    @Published var instructions: String = ""
    @Published var review: DishReviewModel = .new
    @Published var reviews: [String: DishReviewModel] = [:]
    @Published var selectedImage : UIImage?
    @Published var loading: Bool = false
    let dish: Dish
    
    init(dish: Dish){
        self.dish = dish
    }
    
    func addToCart(){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        let item = CartItem(dishname: self.dish.name, dishId: self.dish.id ?? "na", quantity: self.quantity, price: self.dish.price, instructions: self.instructions, restaurantName: self.dish.restaurantName, restaurantId: self.dish.restaurantID)
        do{
            let _ = try FirebaseManager.shared.firestore.collection("users").document(userID).collection("cart").addDocument(from: item)
        } catch{
            print(error)
        }
    }
    
    func uploadPicture(userID: String, dishID: String, completion: @escaping () -> ()) async {
        guard let image = selectedImage else {
            print("No image")
            completion()
            return
        }
        FirebaseManager.shared.storage.reference().child("images/dishes/\(dishID)/\(userID)").putData(image.compressImage()) { metadata, error in
            guard error == nil else{ return }
            let _ = FirebaseManager.shared.storage.reference().child("images/dishes/\(dishID)/\(userID)").downloadURL { url, error in
                guard let url = url else{
                    print("No download url")
                    return
                }
                DispatchQueue.main.async{
                    self.review.imageurl = url.absoluteString
                    completion()
                }
                print("Image uploaded! URL is \(url.absoluteString)")
            }
        }
    }
    
    func loadReviews(){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let dishID = dish.id else {
            print("No dish id for \(dish.name)")
            return
        }
        FirebaseManager.shared.firestore.collection("users").document(dish.restaurantID).collection("dishes").document(dishID).collection("reviews").getDocuments() { (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else{
                print("No documents")
                return
            }
            print("Trying to populate dish reviews")
            let reviews = documents.compactMap { (queryDocumentSnapshot) -> DishReviewModel? in
//                print(queryDocumentSnapshot.data())
                return try? queryDocumentSnapshot.data(as: DishReviewModel.self)
            }
            DispatchQueue.main.async {
                for re in reviews{
                    print(re.id as Any)
                    if re.user == userID{
                        self.review.user = userID
                        print("User has already reviewed this dish")
                    }
                    self.reviews[re.id ?? "nodishreviewid"] = re
                }
            }
        }
        return
    }
    
    /*func getReview() async{
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let dishID = dish.id else {
            print("No dish id for \(dish.name)")
            return
        }
        let docRef = FirebaseManager.shared.firestore.collection("users").document(dish.restaurantID).collection("dishes").document(dishID).collection("reviews").document(userID)
        do{
            if try await docRef.getDocument().exists{
                docRef.getDocument(as: DishReviewModel.self){ result in
                    switch result {
                    case .success(let review):
                        DispatchQueue.main.async {
                            self.review = review
                        }
                    case .failure(let error):
                        print("Error decoding restaurant: \(error)")
                    }
                }
            }
        } catch{
            return
        } 
    }*/
    
    func addReview() async{
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        guard let dishID = dish.id else {
            print("No dish id for \(dish.name)")
            return
        }
        DispatchQueue.main.async {
            self.loading = true
        }
        await uploadPicture(userID: userID, dishID: dish.id!, completion: {
            do{
                self.review.id = userID
                self.review.user = userID
                self.review.userName = FirebaseManager.shared.userDetails.name
                self.review.dishId = dishID
                self.review.restaurantId = self.dish.restaurantID
                self.review.dishname = self.dish.name
                print(self.review)
                let docRef = FirebaseManager.shared.firestore.collection("users").document(self.dish.restaurantID).collection("dishes").document(dishID)
                try docRef.collection("reviews").document(userID).setData(from: self.review) { err in
                    if let err = err {
                        print("Error adding review: \(err)")
                    } else {
                        print("Review added!")
                    }
                }
                var changes: [String: Any] = [
                    "rating": (self.dish.rating ?? 0) + self.review.rating,
                    "ratingcount": (self.dish.ratingcount ?? 0) + 1,
                ]
                if self.review.imageurl != ""{
                    changes["coverImage"] = self.review.imageurl as Any
                }
                docRef.updateData(changes){ err in
                    if let err = err {
                        print("Error updating dish ratings: \(err)")
                    } else {
                        print("Dish ratings updated!")
                        DispatchQueue.main.async {
                            self.reviews[userID] = self.review
                            self.loading = false
                        }
                    }
                }
            } catch{
                print(error)
            }
        })
    }
}

