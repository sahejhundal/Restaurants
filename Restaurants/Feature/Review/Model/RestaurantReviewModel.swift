//
//  RestaurantModel.swift
//  Restaurants
//
//  Created by DON on 11/12/22.
//

import Foundation
import FirebaseFirestoreSwift

struct RestaurantReviewModel: Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var user: String
    var userName: String
    var rating: Int
    var text: String
    enum CodingKeys: String, CodingKey{
        case user
        case userName
        case rating
        case text
    }
}

extension RestaurantReviewModel{
    static var new : RestaurantReviewModel{
        RestaurantReviewModel(user: "", userName: "", rating: 0, text: "")
    }
    static var sample : RestaurantReviewModel{
        RestaurantReviewModel(user: "Slatt", userName: "SLATTIYA", rating: 5, text: "Fire food!")
    }
}
