//
//  SearchBookListViewModel.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 26.12.2021.
//

import Foundation
import Combine

class SearhBookListViewModel:ObservableObject{
    @Published var searchText = ""
    @Published var searchBookList = [SearchBook]()
    @Published var isLoading = false
    var cancellable = Set<AnyCancellable>()
    
    init(){
        search()

    }
    

    
  
        
    
    func search(){
      
        $searchText
            .debounce(for: .milliseconds(1000), scheduler: RunLoop.main)
            .subscribe(on: RunLoop.main)
            .tryMap { value ->String in

                return value
            }
            .sink { comp in
                self.isLoading = false
                print("hata: \(comp)")
            } receiveValue: { [weak self] val in
                self?.searchRequest(value: val)
            }
            .store(in: &cancellable)
    }
    
    
    func searchRequest(value:String){
        isLoading = true
        NetworkManager.sharedInstance.getRequest(endPointUrl: "http:localhost:4000/books/search/\(value)")
            .receive(on: DispatchQueue.main)
            .decode(type: [SearchBook].self, decoder: JSONDecoder())
            .sink { Completion in
                self.isLoading = false
                print(Completion)
            } receiveValue: { [weak self]SearchBook in
                self?.searchBookList = SearchBook
            }
            .store(in: &cancellable)

    }

}
