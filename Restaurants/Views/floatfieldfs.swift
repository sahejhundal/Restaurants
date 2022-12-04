//
//  floatfieldfs.swift
//  Restaurants
//
//  Created by DON on 12/3/22.
//

import SwiftUI

struct floatfieldfs: View {
    @State var text: Double = 0
    var body: some View {
        VStack {
            TextField(value: $text, format: .number) {
                Text("Slatt")
            }
        }
        .multilineTextAlignment(.center)
    }
}

struct floatfieldfs_Previews: PreviewProvider {
    static var previews: some View {
        floatfieldfs()
    }
}
