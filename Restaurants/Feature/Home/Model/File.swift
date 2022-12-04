//
//  File.swift
//  Restaurants
//
//  Created by DON on 10/25/22.
//

import Foundation

enum showingView{
    case home
    case profileEditor
}

class HomeModel: ObservableObject{
    @Published var viewTracker: showingView
    init(){
        viewTracker = .home
    }
}
