//
//  Restaurant.swift
//  Restaurants
//
//  Created by DON on 10/16/22.
//

import Foundation

struct Restaurant: Codable, Identifiable{
    var id: Int
    var name: String
    var imageurl: URL
    var phone: String
    var address: String
    var city: String
    var state: String
    var customdescription: String
    var dishes: [Dish]
}
