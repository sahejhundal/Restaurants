import Foundation
import Combine
import SwiftUI
import FirebaseFirestoreSwift

final class AddDishViewModel: ObservableObject{
    @Published var dish = Dish.new
    @Published var showMenuBuilder: Bool = false
    
    
    func addDish(){
        guard let userID = FirebaseManager.shared.auth.currentUser?.uid else { return }
        self.dish.restaurantID = userID
        self.dish.restaurantName = FirebaseManager.shared.userDetails.name
        do{
            try FirebaseManager.shared.firestore.collection("users").document(userID).collection("dishes").addDocument(from: dish)
            //showMenuBuilder.toggle()
        } catch{
            print(error)
        }
    }
}
