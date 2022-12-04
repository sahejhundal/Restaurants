import Foundation
import Combine
import CoreLocation
import SwiftUI

enum EditUserState{
    case na
    case error
    case successful
}

@MainActor
final class EditUserViewModel: ObservableObject{
    @Published var userDetails: EditUserDetails = .new
    @Published var image: UIImage?
    @Published var loading: Bool = false
    //static let imagePath = "https://firebasestorage.googleapis.com/v0/b/restaurants-b2a42.appspot.com/o/images%2F(userId)?alt=media"
    
    private func getUserInfo(){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        
        let docRef = FirebaseManager.shared.firestore.collection("users").document(userID)
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("data", data)
                    let name = data["name"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let imageurl = data["imageurl"] as? String ?? ""
                    let phone = data["phone"] as? String ?? ""
                    let address = data["address"] as? String ?? ""
                    let city = data["city"] as? String ?? ""
                    let state = data["state"] as? String ?? ""
                    let customdescription = data["customdescription"] as? String ?? ""
                    let isRestaurant = data["isRestaurant"] as? Bool ?? false
                    let lolat = data["lolat"] as? Double ?? 0
                    let lolon = data["lolon"] as? Double ?? 0
                    self.userDetails = EditUserDetails(name: name, email: email, imageurl: imageurl, phone: phone, address: address, city: city, state: state, customdescription: customdescription, isRestaurant: isRestaurant, lolat: lolat, lolon: lolon)
                }else{
                    print("Data not found")
                    return
                }
            }else{
                print("Document doesn't exist", userID)
            }
        }
    }
    
    func getCoords(address: String) async {
        let geocoder = CLGeocoder()
        do{
            let placemarks = try await geocoder.geocodeAddressString(address)
            guard let placemark = placemarks.first else{ return }
            self.userDetails.lolat = placemark.location?.coordinate.latitude ?? 0
            self.userDetails.lolon = placemark.location?.coordinate.longitude ?? 0
        }
        catch{
            print(error.localizedDescription)
        }
        
    }
    
    func uploadProfilePicture() async {
        guard let image = image else {
            return
        }
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        FirebaseManager.shared.storage.reference().child("images/\(userID)").putData(image.compressImage()) { metadata, error in
            guard error == nil else{ return }
            let docRef = FirebaseManager.shared.storage.reference().child("images/\(userID)").downloadURL { url, error in
                guard let url = url else{
                    print("No download url")
                    return
                }
                DispatchQueue.main.async{
                    self.userDetails.imageurl = url.absoluteString
                }
                print("Image uploaded! URL is \(url.absoluteString)")
            }
        }
    }
    
    func makeEdits() async -> Bool {
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return false }
        
        self.loading = true
        
        let fulladdress = self.userDetails.address + ", " + self.userDetails.city
        
        await self.getCoords(address: fulladdress)
        
        if image != nil{
            print("Image recognized")
            await uploadProfilePicture()
            print("upload function finished")
            self.userDetails.imageurl = "https://firebasestorage.googleapis.com/v0/b/restaurants-b2a42.appspot.com/o/images%2F\(userID)?alt=media"
        }else{
            print("No image")
        }
        let docRef = FirebaseManager.shared.firestore.collection("users").document(userID)
        
        let docData: [String: Any] = [
            EditUserKeys.name.rawValue: self.userDetails.name,
            EditUserKeys.email.rawValue: self.userDetails.email,
            EditUserKeys.imageurl.rawValue: self.userDetails.imageurl,
            EditUserKeys.phone.rawValue: self.userDetails.phone,
            EditUserKeys.address.rawValue: self.userDetails.address,
            EditUserKeys.city.rawValue: self.userDetails.city,
            EditUserKeys.state.rawValue: self.userDetails.state,
            EditUserKeys.customdescription.rawValue: self.userDetails.customdescription,
            EditUserKeys.isRestaurant.rawValue: self.userDetails.isRestaurant,
            EditUserKeys.lolon.rawValue: self.userDetails.lolon,
            EditUserKeys.lolat.rawValue: self.userDetails.lolat
            ]
        
        docRef.setData(docData) { error in
            if let error = error {
                print("Error writing document: \(error)")
                
            } else {
                print("Document successfully written!")
                self.loading = false
                FirebaseManager.shared.getUserDetails()
            }
        }
        return true
    }
    init() {
        self.getUserInfo()
    }
}
