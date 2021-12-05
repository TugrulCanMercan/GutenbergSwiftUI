//
//  SwiftUIView.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 4.12.2021.
//

import SwiftUI


struct SwiftUIView: View {
    let categories = ["home","popular","saved"]
    @State private var selected:String = ""
    @Namespace private var namespace
    var body: some View {
        
        HStack{
            ForEach(categories, id:\.self) {category in
                ZStack(alignment: .bottom){
                    if(selected == category){
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.3))
                            .matchedGeometryEffect(id: "category_background", in: namespace)
                            .frame(width: 30, height: 2)
                            .offset(y:10)
                    }
                    Text(category)
                }
                .frame(maxWidth: .infinity)
                .frame(height:55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
                
            }
        }
        .padding(.horizontal    )
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
