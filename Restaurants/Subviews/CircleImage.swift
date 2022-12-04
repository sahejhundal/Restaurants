//
//  CircleImage.swift
//  Restaurants
//
//  Created by DON on 10/18/22.
//

import SwiftUI

struct CircleImage: View {
    let url: String
    //CHICKFILA LOGO
    /*
     https://seeklogo.com/images/C/c-chick-fil-a-logo-9161EF3FCD-seeklogo.com.png
     */
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: url)) { image in
                image.resizable()
                    
            } placeholder: {
                ProgressView()
            }
        }
        .frame(width: 200, height: 200)
        .clipShape(Circle())
        .overlay{
            Circle().stroke(.white,lineWidth: 4)
        }
        .shadow(radius: 10)
        
//        AsyncImage(url: URL(string: url))
           
    }
}

//struct CircleImage_Previews: PreviewProvider {
//    static var previews: some View {
//        CircleImage()
//    }
//}
