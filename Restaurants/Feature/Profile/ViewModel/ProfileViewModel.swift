//
//  ProfileViewModel.swift
//  Restaurants
//
//  Created by DON on 10/26/22.
//

import Foundation
import CoreLocation
import MapKit

class ProfileViewModel: ObservableObject{
    @Published var showProfileEditor: Bool = false
    @Published var dishes : [String: Dish] = [:]
    @Published var orders : [String: Order] = [:]
    
    func clear(){
        self.dishes = [:]
        self.orders = [:]
    }
    
    func initialize(){
        self.loadOrders()
        self.loadDishes()
        
    }
    
    func markOrderComplete(orderId: String){
        guard let userID = Restaurants.FirebaseManager.shared.auth.currentUser?.uid else{
            print("Not authenticated")
            return
        }
        let order = FirebaseManager.shared.firestore.collection("users").document(userID).collection("orders").document(orderId)
        print(orderId)
        order.updateData([
            "status": "Complete"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                self.orders.removeValue(forKey: orderId)
                print("Document successfully updated")
            }
        }
    }
    
    func loadOrders(){
        guard let userID = Restaurants.FirebaseManager.shared.auth.currentUser?.uid else{
            print("Not authenticated")
            return
        }
        FirebaseManager.shared.firestore.collection("users").document(userID).collection("orders").whereField("status", isEqualTo: "Placed")
            .getDocuments() { (querySnapshot, err) in
            
//            .addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
                print("No documents")
                return
            }
            print("Trying to populate orders")
                let orders = documents.compactMap { (queryDocumentSnapshot) -> Order? in
                //print(queryDocumentSnapshot.data())
                return try? queryDocumentSnapshot.data(as: Order.self)
            }
            for order in orders{
                self.orders[order.id?.description ?? "noorderid"] = order
            }
            print("orders are ready")
            print(self.orders)
        }
    }
    
    func loadDishes(){
        guard let userID = Restaurants.FirebaseManager.shared.auth.currentUser?.uid else{
            print("Not authenticated")
            return
        }
        FirebaseManager.shared.firestore.collection("users").document(userID).collection("dishes").getDocuments() { (querySnapshot, err) in
            guard let documents = querySnapshot?.documents else{
                print("No documents")
                return
            }
            print("Trying to populate dishes")
                let dishes = documents.compactMap { (queryDocumentSnapshot) -> Dish? in
                //print(queryDocumentSnapshot.data())
                return try? queryDocumentSnapshot.data(as: Dish.self)
            }
            for dish in dishes{
                self.dishes[dish.id ?? "noorderid"]=dish
            }
        }
    }
    /*
    func loadDishes(){
        guard let userID = Restaurants.FirebaseManager.shared.auth.currentUser?.uid else{
            print("Not authenticated")
            return
        }
        Restaurants.FirebaseManager.shared.firestore.collection("users").document(userID).collection("dishes").getDocuments() { (querySnapshot, err) in
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

