//
//  RestaurantModel.swift
//  Restaurants
//
//  Created by DON on 11/12/22.
//

import Foundation
import FirebaseFirestoreSwift

struct DishReviewModel: Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var dishId: String
    var restaurantId: String
    var dishname: String
    var user: String
    var userName: String
    var rating: Int
    var text: String
    var imageurl: String
    //image
    enum CodingKeys: String, CodingKey{
        case id
        case user
        case userName
        case rating
        case text
        case dishId
        case restaurantId
        case dishname
        case imageurl
    }
}

extension DishReviewModel{
    static var new : DishReviewModel{
        DishReviewModel(dishId: "", restaurantId: "", dishname: "", user: "", userName: "", rating: 0, text: "", imageurl: "")
    }
}
