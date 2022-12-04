//
//  ImagePicker.swift
//  Restaurants
//
//  Created by DON on 11/12/22.
//

import Foundation
import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable{
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    var sourcetype: UIImagePickerController.SourceType = .photoLibrary
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourcetype
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
        print("")
    }
     
    func makeCoordinator() -> (Coordinator) {
        return Coordinator(self)
    }
}

class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var parent: ImagePicker
    
    init(_ picker: ImagePicker){
        self.parent = picker
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // Run code when user has canceled UI
        print("Image cancelled")
        parent.isPickerShowing = false
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Run code when user has selected an image
        print("Image selected")
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            DispatchQueue.main.async {
                self.parent.selectedImage = image
            }
        }
        parent.isPickerShowing = false
    }
}

extension UIImage{
    func compressImage() -> Data {
        //let resizedImage = self.aspectFittedToHeight(200)
        return self.jpegData(compressionQuality: 0.3)! // Add this line
    }
}
