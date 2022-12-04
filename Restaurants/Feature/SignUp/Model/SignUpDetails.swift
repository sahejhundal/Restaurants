//
//  SignUpDetails.swift
//  Restaurants
//
//  Created by DON on 10/17/22.
//

import Foundation

enum SignUpKeys: String{
    case name
    case email
    case password
    case imageurl
    case phone
    case address
    case city
    case state
    case customdescription
}

struct SignUpDetails{
    var name: String
    var email: String
    var password: String
    var imageurl: String
    var phone: String
    var address: String
    var city: String
    var state: String
    var customdescription: String
}

extension SignUpDetails{
    static var new: SignUpDetails{
        SignUpDetails(name: "", email: "", password: "", imageurl: "", phone: "", address: "", city: "", state: "", customdescription: "")
    }
}
