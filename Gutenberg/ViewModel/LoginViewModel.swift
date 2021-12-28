//
//  LoginViewModel.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 4.12.2021.
//

import Foundation
import Combine


class LoginViewModel:ObservableObject{
    @Published var token = ""
    @Published var username:String = ""
    @Published var password:String = ""
    
    var cancellable = Set<AnyCancellable>()
    
    
    init(){
        login()
    }
    
    func login(){
        NetworkManager.sharedInstance.post(endpointUrl: "http:localhost:4000/loginToken", params: getTokenReq(user: User(username: "tugrul",password: "mercan")))
            .receive(on: DispatchQueue.main)
            .map({ data ->String in
                let str = String(data: data, encoding: .utf8)!
                return str
            })
            .sink { com in
                print(com)
            } receiveValue: {[weak self] (token) in
                guard self != nil else {
                    return
                }
                
                UserDefaults.standard.set(token, forKey: "token")
//                UserDefaults.standard.synchronize()
//                self?.token = token
            }
            .store(in: &cancellable)
    }
    
//    let default = UserDefaults.standard
//    default.set(accessToken, forKey: "accessToken")
//    default.synchronized()
//    //Now get like this and use guard so that it will prevent your crash if value is nil.
//    guard let accessTokenValue = default.string(forKey: "accessToken") else {return}
//    print(accessTokenValue)


}

