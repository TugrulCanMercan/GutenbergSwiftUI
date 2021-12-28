//
//  CustomTabBar.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 6.12.2021.
//

import SwiftUI

struct CustomTabBar<Content:View> : View {
    let categories = ["home","popular","saved"]
    let content : Content
    @Namespace var namespace1
    @State var selected = ""
    
    init(@ViewBuilder content:()-> Content){
        self.content = content()
    }
    var body: some View {
        
        VStack(spacing:0){

            
            ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)){
               
                VStack{

                    content
                  
                }
                HStack{
                    ForEach(categories,id:\.self) { category in
                        Spacer()
                        
                        Button {
                            withAnimation (.spring()){
                                selected = category
                            }
                           
                        } label: {
                            VStack{
                                Text(category)
                                    
                                    .foregroundColor(.white)
                                if(selected == category){
                                    RoundedRectangle(cornerRadius: 10)
                                        .matchedGeometryEffect(id: "background", in: namespace1)
                                  
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 2)
                                 
//                                        .offset(y:10)
                                }
                            }.frame(maxWidth: .infinity)
                           
                        }
                        
                        Spacer()
                    }
                }.frame(maxWidth: .infinity)
                    .frame(height:70)
                    .background(Color.red)
            }
        }
       
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar {
            Rectangle()
        }
    }
}
