//
//  CustomCameraView.swift
//  CAM
//
//  Created by DON on 11/28/22.
//

import SwiftUI

struct CustomCameraView: View {
    let cameraService = CameraService()
    @Binding var capturedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        ZStack{
            CameraViewController(cameraService: cameraService) { result in
                switch result{
                case .success(let photo):
                    // handle photo data
                    if let data = photo.fileDataRepresentation(){
                        capturedImage = UIImage(data: data)
                        presentationMode.wrappedValue.dismiss()
                    } else{
                        print("Error: no image data found")
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            
            VStack{
                Spacer()
                Button {
                    cameraService.capturePhoto()
                } label: {
                    Image(systemName: "circle")
                        .font(.system(size: 72))
                        .foregroundColor(.white)
                }
                .padding(.bottom)
            }
        }
    }
}
