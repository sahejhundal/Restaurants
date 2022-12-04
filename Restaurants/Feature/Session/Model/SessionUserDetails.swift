//
//  SessionUserDetails.swift
//  Restaurants
//
//  Created by DON on 10/17/22.
//

import Foundation
import FirebaseFirestoreSwift

struct SessionUserDetails: Identifiable, Codable{
    @DocumentID var id: String? = UUID().uuidString
    var name: String
    var email: String
    var imageurl: String
    var phone: String
    var address: String
    var city: String
    var state: String
    var customdescription: String
    var rating: Int? = 0
    var ratingcount: Int? = 0
    
    var isRestaurant: Bool
    
    var lolat: Double
    var lolon: Double
    
    //var dishes: [Dish]
}

extension SessionUserDetails{
    static var new: SessionUserDetails{
        SessionUserDetails(name: "N/A", email: "", imageurl: "https://seeklogo.com/images/C/c-chick-fil-a-logo-9161EF3FCD-seeklogo.com.png", phone: "", address: "", city: "", state: "", customdescription: "", rating: 0, isRestaurant: false, lolat: 0, lolon: 0)
    }
    static var parmishverma: SessionUserDetails{
        SessionUserDetails(name: "Parmish Verma", email: "parmishverma@gmail.com", imageurl: "https://i0.wp.com/www.socialnews.xyz/wp-content/uploads/2022/04/20/0c427cdecf81a03eba0a3d5ea4a13e21.jpg", phone: "+91PARMISHVERMA", address: "MUSTANDA", city: "TOWN", state: "CHANDIGARH", customdescription: "<...>", rating: 5, ratingcount: 1,isRestaurant: false, lolat: 37.5134731, lolon: -121.9814348)
    }
}
