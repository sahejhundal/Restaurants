//
//  FirebaseManager.swift
//  Restaurants
//
//  Created by DON on 10/23/22.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseFirestoreSwift
import FirebaseStorage

class FirebaseManager: NSObject, ObservableObject{
    let auth: Auth
    let storage: Storage
    let firestore: Firestore
    
    @Published var userDetails = SessionUserDetails.new
    
    static let shared = FirebaseManager()
    
    override init(){
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        
        super.init()
        
        //self.initializeUserDetails()
    }
    
    func initializeUserDetails(){
        self.getUserDetails()
    }
    
    func getUserDetails(){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else{
            return
        }
        
        let docRef = FirebaseManager.shared.firestore.collection("users").document(userID)
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    //print("data", data)
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
                    //let dishes = data["dishes"] as? [[String: Any]] ?? [[:]]
                    let userDetails = SessionUserDetails(name: name, email: email, imageurl: imageurl, phone: phone, address: address, city: city, state: state, customdescription: customdescription, isRestaurant: isRestaurant, lolat: lolat, lolon: lolon)//, dishes: dishes)
                    DispatchQueue.main.async {
                        self.userDetails = userDetails
                    }
                    return
                }else{
                    print("Data not found")
                    return
                }
            }else{
                print("Document doesn't exist", userID)
            }
        }
    }
    
    func updateUserValues(from docData: [String: Any]){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let docRef = FirebaseManager.shared.firestore.collection("users").document(userID)
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            docRef.setData(docData) { error in
                if let error = error {
                    print("Error writing document: \(error)")
                } else {
                    print("Document successfully written!")
                }
            }
        }
    }
    
    func processDishes(from input: [[String:Any]]){
        //var dishes : [Dish] = []
        print("PROCESSDISHES\n\n\n\n")
        input.forEach { a in
            
        }
        for i in 0..<input.count{
            print(input[i])
        }
    }
}
