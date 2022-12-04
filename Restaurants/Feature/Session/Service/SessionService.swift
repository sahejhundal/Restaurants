//
//  SessionService.swift
//  Restaurants
//
//  Created by DON on 10/17/22.
//

import Foundation
import Combine
import FirebaseAuth
import Firebase

enum SessionState{
    case loggedIn
    case loggedOut
}

protocol SessionService{
    var state: SessionState{ get }
    var userDetails: SessionUserDetails?{ get }
    func logout()
}

final class SessionServiceImpl: ObservableObject, SessionService{
    @Published var state: SessionState = .loggedOut
    @Published var userDetails: SessionUserDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    
    init(){
        setupFirebaseHandler()
        //FirebaseManager.shared.initializeUserDetails()
    }
    
    func logout() {
        try? Auth.auth().signOut()
        self.userDetails = .new
    }
}

private extension SessionServiceImpl{
    func setupFirebaseHandler(){
        handler = Auth
            .auth()
            .addStateDidChangeListener{[weak self] res, user in
                guard let self = self else{ return }
                self.state = user == nil ? .loggedOut : .loggedIn
                if let uid = user?.uid {
                    self.handleRefresh(with: uid)
                }
            }
    }
    
    func handleRefresh(with uid: String){
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(uid)
        
        docRef.getDocument(as: SessionUserDetails.self) { result in
            switch result {
            case .success(let sud):
                DispatchQueue.main.async {
                    self.userDetails = sud
                    FirebaseManager.shared.userDetails = sud
                }
            case .failure(let error):
                print("Error decoding city: \(error)")
            }
        }
        /*
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
                    DispatchQueue.main.async {
                        let userDetails = SessionUserDetails(name: name, email: email, imageurl: imageurl, phone: phone, address: address, city: city, state: state, customdescription: customdescription, isRestaurant: isRestaurant, lolat: lolat, lolon: lolon)
                        self.userDetails = userDetails
                        FirebaseManager.shared.userDetails = userDetails
                    }
                }else{
                    print("Data not found")
                    return
                }
            }else{
                print("Document doesn't exist", uid)
            }
        }
        */
    }
}


