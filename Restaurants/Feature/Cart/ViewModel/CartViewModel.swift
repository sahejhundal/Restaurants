//
//  ProfileViewModel.swift
//  Restaurants
//
//  Created by DON on 10/26/22.
//

import Foundation

class CartViewModel: ObservableObject{
    @Published var cartItems : [String: CartItem] = [:]
    
    func clearCart(){
        self.cartItems = [:]
    }
    
    func submitOrder(){
        guard let userID = Restaurants.FirebaseManager.shared.auth.currentUser?.uid else{
            print("Not authenticated")
            return
        }
        
        var orders : [String: [CartItem]] = [:]
        var prices : [String: Double] = [:]
        
        
        for item in cartItems{
            print("in for loop")
            print(item)
            if orders[item.key] != nil{
                orders[item.key]!.append(item.value)
            } else{
                orders[item.key] = [item.value]
            }
            
            prices[item.key, default: 0] += item.value.price * Double(item.value.quantity)
        }
        
        for restaurant in orders{
            let ORDER = Order(customerName: FirebaseManager.shared.userDetails.name, customerId: userID, status: "Placed", timestamp: Date.now, restaurantId: restaurant.key, restaurantName: restaurant.value.first?.restaurantName ?? "", totalprice: prices[restaurant.key] ?? 0, cartItems: orders[restaurant.key] ?? [])
            
            do{
                let result = try FirebaseManager.shared.firestore.collection("users").document(restaurant.value.first!.restaurantId).collection("orders").addDocument(from: ORDER)
            } catch{
                print(error)
            }
        }
        
        for item in self.cartItems.values{
            guard let id = item.id else{ continue }
            self.removeFromCart(itemID: id)
        }
        DispatchQueue.main.async {
            self.cartItems = [:]
        }
    }
    
    func loadCartItems(){
        guard let userID = Restaurants.FirebaseManager.shared.auth.currentUser?.uid else{
            print("Not authenticated")
            return
        }
        
        Restaurants.FirebaseManager.shared.firestore.collection("users").document(userID).collection("cart").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let id = document.documentID.description.description
                    let dishname = data["dishname"] as? String ?? ""
                    let dishId = data["dishId"] as? String ?? ""
                    let quantity = data["quantity"] as? Int ?? 0
                    let price = data["price"] as? Double ?? 0
                    let restaurantName = data["restaurantName"] as? String ?? ""
                    let restaurantId = data["restaurantId"] as? String ?? ""
                    let instructions = data["instructions"] as? String ?? ""
                    let item = CartItem(id: id, dishname: dishname, dishId: dishId, quantity: quantity, price: price, instructions: instructions, restaurantName: restaurantName, restaurantId: restaurantId)
                    DispatchQueue.main.async {
                        self.cartItems[id] = item
                    }
                }
                return
            }
        }
        
        /*
        FirebaseManager.shared.firestore.collection("users").document(userID).collection("cart").addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else{
                print("No documents")
                return
            }
            print("Trying to populate cart")
            self.cartItems = documents.compactMap { (queryDocumentSnapshot) -> CartItem? in
                //print(queryDocumentSnapshot.data())
                return try? queryDocumentSnapshot.data(as: CartItem.self)
            }
        }
        */
    }
    
    func removeFromCart(itemID: String){
        guard let userID = Restaurants.FirebaseManager.shared.auth.currentUser?.uid else{
            print("Not authenticated")
            return
        }
        FirebaseManager.shared.firestore.collection("users").document(userID).collection("cart").document(itemID).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                self.cartItems.removeValue(forKey: itemID)
            }
        }
    }
}

