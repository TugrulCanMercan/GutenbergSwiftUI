//
//  HomeViewModel.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 26.12.2021.
//

import Foundation
import Combine
class HomeViewModel : ObservableObject{
    
    @Published var popularBooks = [Book]()
    
    var cancellable = Set<AnyCancellable>()
    init(){
        getPopularBooks()
    }
    
    func getPopularBooks(){
        NetworkManager.sharedInstance.getRequest(endPointUrl: "http:localhost:4000/popularBooks")
            .receive(on: DispatchQueue.main)
            .decode(type: [Book].self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .failure(let error): print("Error \(error)")
                case .finished: print("Publisher is finished")
                }
            } receiveValue: { [weak self]Books in
                self?.popularBooks = Books
                
            }
            .store(in: &cancellable)
    }
}
