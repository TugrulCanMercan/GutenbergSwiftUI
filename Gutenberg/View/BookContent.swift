//
//  BookDetailView.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 26.12.2021.
//

import SwiftUI

struct BookContentView: View {
    @StateObject var bookContentVM : BookContentViewModel
    
    init(bookId:String){
        self._bookContentVM = StateObject(wrappedValue: BookContentViewModel(bookId: bookId))
    }
    
    var body: some View {
        VStack{
            ScrollView{
                ForEach(bookContentVM.bookContent.sorted(by: <), id: \.key) {key,Value in
                    ZStack{
                        VStack{
                            Text("\(key)")
                                .font(.largeTitle)
                                .background(Color.red)
                            Text(Value)
                        }
                        if(bookContentVM.isLoading){
                            ProgressView()
                        }
                    }
                   
                }
            }
             
        }
    }
}

//struct BookContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookContentView()
//    }
//}
