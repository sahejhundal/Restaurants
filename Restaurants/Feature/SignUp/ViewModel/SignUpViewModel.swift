import Foundation
import Combine

enum SignUpState{
    case successful
    case failed(error: Error)
    case na
}

protocol SignUpViewModel{
    func signup()
    var service: SignUpService{get}
    var state: SignUpState{get}
    var userDetails: SignUpDetails{get}
    init(service: SignUpService)
}

final class SignUpViewModelImpl: ObservableObject, SignUpViewModel{
    let service: SignUpService
    
    @Published var state: SignUpState = .na
    
    @Published var userDetails: SignUpDetails = .new
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: SignUpService) {
        self.service=service
    }
    
    func signup() {
        service
            .signup(with: userDetails)
            .sink { [weak self] res in
                switch res{
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                }
            } receiveValue: { [weak self] in
                self?.state = .successful
            }
            .store(in: &subscriptions)
    }
}
