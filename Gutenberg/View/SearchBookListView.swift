//
//  SearchBookListView.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 26.12.2021.
//

import SwiftUI

struct SearchBookListView: View {
//    @State var searhBookText = ""
    @StateObject var searchListVM = SearhBookListViewModel()
    var body: some View {
        NavigationView{
            VStack{
                TextField("Search", text: $searchListVM.searchText)
                    
                    .padding(.vertical,10)
                    .background(RoundedRectangle(cornerRadius: 10).strokeBorder())
                    .padding(.horizontal)
                    

                    VStack{
                        ZStack{
                            
                            List{
                                ForEach(searchListVM.searchBookList,id:\.self) {book in
                                    
                                    
                                    NavigationLink(destination: BookContentView(bookId: book.link)) {
                                            HStack{
                                                DownloadingImageView(url: book.image)
                                                    
                                                    .frame(width: 75,height: 75)
                                                VStack(alignment:.leading){
                                                    Text(book.title)
                                                        
                                                    Text(book.subtitle)
                                                }
                                                Spacer()
                                                Text(book.extra)
                                                    .frame(maxHeight:.infinity,alignment: .bottom)
                                            }
                                            .frame(height:80)
                                           
                                        }
                                    
                                   
                                    }
                            }
                            if(searchListVM.isLoading){
                                ProgressView()
                            }
                           
                        }
                       

                    }
                
     
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle("BookSearch")
        }
       
    }
}

struct SearchBookListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBookListView()
    }
}
