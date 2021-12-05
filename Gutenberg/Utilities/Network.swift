//
//  Network.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 4.12.2021.
//

import Foundation
import Combine

enum AuthenticationError:Error{
    case sessionFailed(error: URLError)
    case invalidCredentials
    case custom(errorMessage:String)
    case decodingFailed
    case other(Error)
}

class NetworkManager {
    
    
    static let sharedInstance = NetworkManager()
    
    
    private init() {
        // Only methods within the class can access here
    }
    
    
    func post<T:Codable>(endpointUrl:String,params:T) ->AnyPublisher<Data,Error>{
        //        let jsonType = try JSONSerialization.jsonObject(with: params, options: [])
        let encoder = JSONEncoder()
        
        encoder.outputFormatting = .prettyPrinted
        let data = try? encoder.encode(params)
        guard let url = URL(string: endpointUrl) else {
            return AnyPublisher(Fail<Data,Error>(error: URLError(.badURL)))
        }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = data
        
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data,response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .eraseToAnyPublisher()
    }
    
    func post(endpointUrl:String,params:[String:Any])->AnyPublisher<Data,AuthenticationError>{
        //        let dataa = JSONSerialization.jsonObject(with: params, options: []) as? [String: Any]
        //        let data = try? encoder.encode(params)
        guard let url = URL(string: endpointUrl) else {
            return AnyPublisher(Fail<Data,AuthenticationError>(error: AuthenticationError.sessionFailed(error: URLError(.badURL))))
        }
        
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted) else {
            return AnyPublisher(Fail<Data,AuthenticationError>(error: AuthenticationError.custom(errorMessage: "httpBody hatası json serialization")))
        }
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = httpBody
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data,response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else{
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .mapError({ error in
                switch error {
                case is Swift.DecodingError:
                    return .decodingFailed
                case let urlError as URLError:
                    return .sessionFailed(error: urlError)
                default:
                    return .other(error)
                }
            })
            .eraseToAnyPublisher()
        
    }
}
