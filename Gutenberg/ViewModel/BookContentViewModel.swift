//
//  BookContentViewModel.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 27.12.2021.
//

import Foundation
import Combine

class BookContentViewModel:ObservableObject{

    
    @Published var bookContent:[Int:String] = [:]
    @Published var isLoading = false
    var cancellable = Set<AnyCancellable>()
    let bookId:String
    
    init(bookId:String){
        self.bookId = bookId
        getContent()
    }
    
    func getContent(){
        
        isLoading = true
        NetworkManager.sharedInstance.getRequest(endPointUrl:   "https://www.gutenberg.org/cache/epub/\(bookId)/pg\(bookId).txt")
            .receive(on: DispatchQueue.main)
            .map { data ->[Int:String] in
                let content = String(data: data, encoding: .utf8) ?? "boş"
                let newContent = content.components(separatedBy: "\n")
                var strArr: [Int:String] = [:]
                var count = 0
                var page = 0
                var str = ""
                
                for item in newContent.indices{
                    if(item != 0 && item % 500 == 0){
                        strArr[page] = str
                        page += 1
                        str = ""
                    }else{
                        str += newContent[count]
                        str += " "
                        count += 1
                    }
                }
                
                
                return strArr
            }
            .sink { Completion in
                self.isLoading = false
                print("hata kontrol kitap içeriği: \(Completion)")
            } receiveValue: {[weak self] content in
                self?.bookContent = content
            }
            .store(in: &cancellable)

    }
}
