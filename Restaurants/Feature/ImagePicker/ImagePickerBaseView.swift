//
//  ImagePickerView.swift
//  Restaurants
//
//  Created by DON on 11/12/22.
//

import SwiftUI

struct ImagePickerBaseView: View {
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var sourcetype: UIImagePickerController.SourceType = .photoLibrary
    var body: some View {
        VStack{
            if selectedImage != nil{
                Image(uiImage: selectedImage!)
                    .resizable()
                    .frame(width: 200, height: 200)
            }
            Button{
                sourcetype = .camera
                isPickerShowing = true
                
            } label: {
                Text("Camera")
            }
            Button{
                sourcetype = .photoLibrary
                isPickerShowing = true
                
            } label: {
                Text("Select a photo")
            }
        }
        .sheet(isPresented: $isPickerShowing) {
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, sourcetype: sourcetype)
        }
    }
}

struct ImagePickerBaseView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerBaseView()
    }
}
