//
//  UserAuth.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 5.12.2021.
//

import Foundation
import Combine

class Auth : ObservableObject{
    @Published var authStatus:Bool = false
    var cancellabe = Set<AnyCancellable>()
    init(){
        userAuthCheck()
    }
    
    func userAuthCheck(){
        //token check fake api yarat
        NetworkManager.sharedInstance.post(endpointUrl: "http:localhost:4000/tokenCheck", params: ["token":UserDefaults.standard.string(forKey: "token")])
            .receive(on: DispatchQueue.main)
            .decode(type: AuthStatus.self, decoder: JSONDecoder())
            .tryMap({ AuthStatus ->Bool in
                guard AuthStatus.status == true else {return false}
                
                return AuthStatus.status
            })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    break
                }
            } receiveValue: {[weak self] status in
                self?.authStatus = status
            }
            .store(in: &cancellabe)
        
        //
        //            .mapError({ error in
        //                switch error {
        //                case is Swift.DecodingError:
        //                    return .decodingFailed
        //                case let urlError as URLError:
        //                    return .sessionFailed(error: urlError)
        //                default:
        //                    return .other(error)
        //                }
        //            })
        
        
    }
    
}
