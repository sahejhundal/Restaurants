//
//  PlaygroundView.swift
//  Restaurants
//
//  Created by DON on 11/30/22.
//

import SwiftUI

struct PlaygroundView: View {
    @State var spin = true
    let colors : [Color] = [.yellow, .orange, .red, .pink]
    @State var color = Color.black
    @State var wiggle = false
    
    var body: some View {
        VStack{
            Text("$")
                .font(.system(size: 500))
                .bold()
                .rotation3DEffect(Angle.degrees(spin ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                .foregroundColor(color)
                .shadow(color: .red, radius: 15)
            VStack{
                Text("Wiggle")
                .rotationEffect(Angle(degrees: wiggle ? 15 : 0))
            }
            .onTapGesture {
                withAnimation {
                    wiggle.toggle()
                }
            }

        }
        .onAppear{
            withAnimation(Animation.linear.speed(0.1).repeatForever(autoreverses: false)){
                spin.toggle()
            }
        }
    }
}

struct PlaygroundView_Previews: PreviewProvider {
    static var previews: some View {
        PlaygroundView()
    }
}
