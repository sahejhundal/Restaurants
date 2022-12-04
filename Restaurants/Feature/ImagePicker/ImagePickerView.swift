//
//  ImagePickerView.swift
//  Restaurants
//
//  Created by DON on 11/12/22.
//

import SwiftUI

struct ImagePickerView: View {
    @State var isPickerShowing = false
    @Binding var selectedImage: UIImage?
    @State var sourcetype: UIImagePickerController.SourceType = .photoLibrary
    var body: some View {
        VStack{
            if selectedImage != nil{
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            HStack{
                Button{
                    sourcetype = .camera
                    isPickerShowing = true
                } label: {
                    Image(systemName: "camera")
                }
                
                Button{
                    sourcetype = .photoLibrary
                    isPickerShowing = true
                } label: {
                    Image(systemName: "photo")
                }
            }
            .font(.system(size: 30))
            .shadow(radius: 5)
            
        }
        .sheet(isPresented: $isPickerShowing) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, sourcetype: sourcetype)
        }
    }
}

//struct ImagePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImagePickerView()
//    }
//}
