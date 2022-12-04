//
//  Order.swift
//  Restaurants
//
//  Created by DON on 11/9/22.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

struct Order: Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var customerName: String
    var customerId: String
    var status: String
    var timestamp: Date
    var restaurantId: String
    var restaurantName: String
    var totalprice: Double
    var cartItems: [CartItem]
    enum CodingKeys: String, CodingKey{
        case id
        case customerName
        case customerId
        case status
        case timestamp
        case restaurantId
        case restaurantName
        case totalprice
        case cartItems
    }
}

extension Order{
    static var new: Order{
        Order(id: "", customerName: "", customerId: "", status: "", timestamp: Date.now, restaurantId: "", restaurantName: "", totalprice: 0, cartItems: [])
    }
    static var parmishverma: Order{
        Order(customerName: "Parmish Verma", customerId: "userID", status: "Placed", timestamp: Date.now, restaurantId: "restaurant.key", restaurantName: "Mohali Dhaba", totalprice: 1000.99, cartItems: [CartItem(dishname: "Butter Chicken", dishId: "", quantity: 2, price: 12.99, instructions: "Make it spicy bitch", restaurantName: "Mohali Dhaba", restaurantId: ""), CartItem(dishname: "Chili Chicken", dishId: "", quantity: 3, price: 12.99, instructions: "Make it spicy bitch", restaurantName: "Mohali Dhaba", restaurantId: "")])
    }
}
