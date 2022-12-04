//
//  SignUpService.swift
//  Restaurants
//
//  Created by DON on 10/18/22.
//

import Foundation
import Combine
import Firebase

protocol SignUpService{
    func signup(with details: SignUpDetails) -> AnyPublisher<Void,Error>
}

final class SignUpServiceImpl: SignUpService{
    func signup(with details: SignUpDetails) -> AnyPublisher<Void, Error> {
        Deferred{
            Future{ promise in
                Auth.auth()
                    .createUser(withEmail: details.email, password: details.password){ res, error in
                        if let err = error{
                            promise(.failure(err))
                        } else{
                            
                            if let uid = res?.user.uid{
                                let db = Firestore.firestore()

                                let docRef = db.collection("users").document(uid)
                                
                                let docData: [String: Any] = [
                                    SignUpKeys.name.rawValue: details.name,
                                    SignUpKeys.email.rawValue: details.email,
                                    SignUpKeys.imageurl.rawValue: details.imageurl,
                                    SignUpKeys.phone.rawValue: details.phone,
                                    SignUpKeys.address.rawValue: details.address,
                                    SignUpKeys.city.rawValue: details.city,
                                    SignUpKeys.state.rawValue: details.state,
                                    SignUpKeys.customdescription.rawValue: details.customdescription
                                    ]

                                docRef.setData(docData) { error in
                                    if let error = error {
                                        print("Error writing document: \(error)")
                                    } else {
                                        print("Document successfully written!")
                                        promise(.success(()))
                                    }
                                }
                            }
                            else{
                                promise(.failure(NSError(domain: "Invalid User ID", code: 0, userInfo: nil)))
                            }
                        }
                    }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
