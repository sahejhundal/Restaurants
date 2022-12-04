//
//  EditUserDetails.swift
//  Restaurants
//
//  Created by DON on 10/18/22.
//

import Foundation

import Combine
import Firebase

enum EditUserKeys: String{
    case name
    case email
    case imageurl
    case phone
    case address
    case city
    case state
    case customdescription
    case isRestaurant
    case lolat
    case lolon
}

struct EditUserDetails{
    var name: String
    var email: String
    var imageurl: String
    var phone: String
    var address: String
    var city: String
    var state: String
    var customdescription: String
    var isRestaurant: Bool
    var lolat: Double
    var lolon: Double
}

extension EditUserDetails{
    static var new: EditUserDetails{
        EditUserDetails(name: "", email: "", imageurl: "", phone: "", address: "", city: "", state: "", customdescription: "", isRestaurant: false, lolat: 0, lolon: 0)
    }
}
