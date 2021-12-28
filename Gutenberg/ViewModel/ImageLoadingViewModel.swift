//
//  ImageLoadingViewModel.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 26.12.2021.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadViewModel :ObservableObject{
    
    @Published var image:UIImage? = nil
    @Published var isLoading:Bool = false
    let urlString:String
    var cancellable = Set<AnyCancellable>()
    init(urlStirng:String){
        self.urlString = urlStirng
        downloadImage()
    }
    func downloadImage(){
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        URLSession.shared.dataTaskPublisher(for: url)
            .map{UIImage(data: $0.data)}
            .receive(on: DispatchQueue.main)
            .sink { [weak self]com in
                self?.isLoading = false
                print(com)
            } receiveValue: { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellable)

    }
    
}
