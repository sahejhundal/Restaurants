//
//  Dish.swift
//  Restaurants
//
//  Created by DON on 8/26/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Dish: Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var codename: String
    var restaurantName: String
    var restaurantID: String
    var description: String
    var name: String
    var price: Double
    var vegan: Bool
    var meat: String
    var protein: Int
    var sugar: Int
    var fat: Int
    var rating: Int? = 0
    var ratingcount: Int? = 0
    var coverImage: String?
    enum CodingKeys: String, CodingKey{
        case id
        case codename
        case name
        case description
        case price
        case restaurantName
        case restaurantID
        case vegan
        case meat
        case protein
        case sugar
        case fat
        case rating
        case ratingcount
        case coverImage
    }
}

extension Dish{
    static var new : Dish{
        Dish(codename: "", restaurantName: "", restaurantID: "", description: "", name: "", price: 0, vegan: false, meat: "", protein: 0, sugar: 0, fat: 0, coverImage: "")
    }
    static var butterchicken : Dish{
        Dish(codename: "butterchicken", restaurantName: "Hundal", restaurantID: "1", description: "Butter chicken, traditionally known as murgh makhani, is an Indian dish. It is a type of curry made from chicken with a spiced tomato and butter sauce. Its sauce is known for its rich texture. It is similar to chicken tikka masala, which uses a tomato paste.", name: "Butter Chicken", price: 13.99, vegan: false, meat: "Chicken", protein: 10, sugar: 5, fat: 10, coverImage: "https://cafedelites.com/wp-content/uploads/2019/01/Butter-Chicken-IMAGE-64.jpg")
    }
}
