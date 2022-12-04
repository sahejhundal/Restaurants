//
//  DishReviewView.swift
//  Restaurants
//
//  Created by DON on 11/12/22.
//

import SwiftUI

struct DishReviewView: View {
    typealias ActionHandler = () -> Void
    @State var isPickerShowing = false
    @Binding var selectedImage : UIImage?
    @Binding var review: DishReviewModel
    let handler: ActionHandler
    
    let ogSize: CGFloat = 120
    @State var sizeQ: CGFloat = 120
    
    internal init(isPickerShowing: Bool = false, selectedImage: Binding<UIImage?>, review: Binding<DishReviewModel>, handler: @escaping DishReviewView.ActionHandler){
        self.isPickerShowing = isPickerShowing
        self._selectedImage = selectedImage
        self._review = review
        self.handler = handler
    }
    
    var body: some View {
        VStack{
            FiveStarElement(rating: $review.rating)
                .padding(.bottom, 10)
            HStack{
                Button {
                    isPickerShowing = true
                } label: {
                    ZStack{
                        Circle()
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                        Image(systemName: "camera")
                            .foregroundColor(.black)
                            .opacity(0.5)
                            .shadow(radius: 10)
                    }
                    .font(.system(size: 20))
                    
                }
                ZStack{
                    TextEditor(text: $review.text)
                        .font(.system(size: 22))
                        //.frame(minWidth: 250, minHeight: 80, maxHeight: 100)
                    if review.text == ""{
                        Text("Write your review...")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    }
                }
            }
            .shadow(radius: 5)
//            .padding()
            
            if review.text != "" && review.rating != 0{
                ButtonComponentView(title: "Let the world know!", background: .yellow, foreground: .black, handler: self.handler) 
                .frame(minHeight: 50)
                .padding(.horizontal)
            }
        }
        .padding()
        .sheet(isPresented: $isPickerShowing) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, sourcetype: UIImagePickerController.SourceType.camera)
        }
    }
}

//struct DishReviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        DishReviewView()
//    }
//}
