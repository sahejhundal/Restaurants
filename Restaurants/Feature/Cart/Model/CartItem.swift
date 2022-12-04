//
//  Order.swift
//  Restaurants
//
//  Created by DON on 11/9/22.
//

import Foundation
import FirebaseFirestoreSwift

struct CartItem: Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var dishname: String
    var dishId: String
    var quantity: Int
    var price: Double
    var instructions: String
    var restaurantName: String
    var restaurantId: String
}

extension CartItem{
    static var new: CartItem{
        CartItem(dishname: "", dishId: "", quantity: 0, price: 0, instructions: "", restaurantName: "", restaurantId: "")
    }
}
