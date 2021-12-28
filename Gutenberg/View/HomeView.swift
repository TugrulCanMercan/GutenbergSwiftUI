//
//  HomeView.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 4.12.2021.
//

import SwiftUI

//enum selectedTab {
//    case home
//    case search
//    case profil
//}
struct Tab : Identifiable,Equatable{
    let id:Int
    let label: String
    let image:String
}

let tabs = [
    Tab(id:0,label: "Home", image: "house"),
    Tab(id:1,label: "Person", image: "person"),
    Tab(id:2,label: "HomeKit", image: "homekit")
]

struct HomeView: View {
    @State var seclection:Int = 1
    @Namespace private var currentTab
    @StateObject var homeViewModel = HomeViewModel()
    @State var image = UIImage()
    //    init() {
    //        UITabBar.appearance().backgroundColor = UIColor.yellow
    //
    //    }
    var body: some View {
        
        TabView{
            NavigationView{
                VStack{
                    HStack{
                        Text("GutenBerg")
                            .font(.largeTitle)
                            .padding(.bottom,2)
                    }
                    .frame(maxWidth: .infinity)
                    .background(AngularGradient(colors: [Color.gray,Color.yellow], center: .center, startAngle: .degrees(270), endAngle: .radians(10)).edgesIgnoringSafeArea(.top))
                    
                    Text("Popular 10 books")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,4)
                    //viewModels
                    ScrollView(.horizontal){
                        LazyHStack(alignment: .top){
                            ForEach(homeViewModel.popularBooks,id:\.self) { book in
                                VStack{
                                    
                                    DownloadingImageView(url: book.image)
                                        
                                        .cornerRadius(20)
                                    
                                   
                                    Text(book.title)
                                        .multilineTextAlignment(.center)
                                        .lineLimit(2)
                                }.frame(width: UIScreen.main.bounds.width*0.5-4)
                                
                                
                            }
                        }
                    }
                    .frame(height: 150)
                    Text("my last read")
                        .frame(maxWidth: .infinity,alignment: .leading)
                        .padding(.leading,4)
                    ScrollView{
                        LazyVStack {
                            ForEach(0...50,id:\.self) {_ in
                                NavigationLink {
                                    Text("ssss")
                                } label: {
                                    HStack{
                                        Text("dsds")
                                        Spacer()
                                        Text("dsds")
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 20).strokeBorder()
                                                    .foregroundColor(Color.gray))
                                    
                                    
                                }
                                
                            }
                        }
                    }.padding(EdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4))
                    
                    
                }
                .navigationBarHidden(true)
                
            }
            .tabItem {
                Image(systemName: "person")
                
            }
            SearchBookListView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            
            Rectangle()
                .tabItem {
                    Image(systemName: "house")
                }
        }
        
        
        
        
        
        
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
