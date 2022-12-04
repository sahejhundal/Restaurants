//
//  AddToCartPopUpView.swift
//  Restaurants
//
//  Created by DON on 11/9/22.
//

import SwiftUI

struct DishDetailView: View {
//    var dish: Dish
//    @State var quantity: Int = 1
//    @State var instructions: String = ""
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var vm: DishDetailViewModel
    @State var isCameraShowing = false
    var body: some View {
        ZStack{
            if vm.loading == true{
                ZStack{
                    Text("HOLD UP").font(.system(size: 50))
                        .frame(width: 1000, height: 1000)
                        .background(.gray)
                        .opacity(0.6)
                }
            } else{
                ScrollView{
                    VStack{
                        VStack{
                            VStack{
                                HStack(){
                                    Text(vm.dish.name)
                                        .font(.title2).bold()
                                    Spacer()
                                    Text("$" + String(vm.dish.price)).font(.title2).bold()
                                }//.padding(.horizontal)
                                HStack(){
                                    Text(vm.dish.description)
                                        .font(.body)
                                        .multilineTextAlignment(.leading)
                                }//.padding(.horizontal)
                            }.padding()
                                .background(.white)
                                .shadow(radius: 15)
                                .padding(.vertical)
                        }
                        .foregroundColor(.black)
                        VStack{
                            Text("Configure item")
                                .font(.system(.title))
                                .padding()
                            HStack{
                                Button {
                                    if vm.quantity > 1{
                                        vm.quantity-=1
                                    }
                                } label: {
                                    Image(systemName: "minus")
                                }
                                
                                Spacer()
                                Text("\(vm.quantity)")
                                Spacer()
                                
                                Button {
                                    if vm.quantity < 10{
                                        vm.quantity+=1
                                    }
                                } label: {
                                    Image(systemName: "plus")
                                }
                            }.font(.system(.title2))
                            InputTextField(text: $vm.instructions, placeholder: "Instructions", keyboardType: .default, sfSymbol: "note.text")
                                .padding(.bottom, 20)
                            ButtonComponentView(title: "Add to cart", background: .orange, foreground: .white, border: .orange) {
                                vm.addToCart()
                                print("order submitted")
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            .frame(minHeight: 50)
                            
                        }
                        //.frame(minWidth: 300, minHeight: 250)
                        .padding(25)
                        //.border(.gray, width: 2)
                        .background(.white)
                        .shadow(radius: 10)
                        
                        VStack {
                            Text("Customer Reviews").font(.headline).bold().padding(.bottom, 5)
                            ForEach(Array(vm.reviews), id: \.key) { key, value in
                                //                            let _ = print("\(key) : \(value)")
                                ZStack {
                                    Rectangle().opacity(0.06)
                                    StaticDishReviewView(review: value)
                                        .padding(.vertical, 4)
                                }
                                .cornerRadius(3)
                                Divider()
                            }
                        }
                        .padding(.vertical, 7)
                        
                        if vm.review.user == ""{
                            DishReviewView(selectedImage: $vm.selectedImage, review: $vm.review){
                                print("submit review clicked")
                                Task{
                                    await vm.addReview()
                                }
                            }
                            .padding(.vertical)
                            .background(.purple)
                            .shadow(radius: 10)
                        }
                    }
                    .padding()
                }
            }
        }
        .onAppear{
            vm.loadReviews()
        }
        .sheet(isPresented: $isCameraShowing) {
            CustomCameraView(capturedImage: $vm.selectedImage)
        }
    }
}

struct DishDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DishDetailView(vm: DishDetailViewModel(dish: .butterchicken))
    }
}
