//
//  LoginCredentials.swift
//  Restaurants
//
//  Created by DON on 10/18/22.
//

import Foundation

struct LoginCredentials{
    var email: String
    var password: String
}

extension LoginCredentials{
    static var new: LoginCredentials{
        LoginCredentials(email: "", password: "")
    }
}
