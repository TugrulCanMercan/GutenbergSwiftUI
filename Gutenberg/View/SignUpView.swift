//
//  SignUpView.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 28.12.2021.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject var SignUpVM = SignUpViewModel()
    var body: some View {
        VStack(){
            
            Text("Gutenberg")
                .font(.largeTitle)
                .italic()
                .bold()
                .foregroundColor(Color.red)
                .frame(height:100,alignment: .top)
            HStack{
                TextField("Username", text: $SignUpVM.username)
                if(!SignUpVM.username.isEmpty){
                    Image(systemName: "person")
                }
              
            } .padding()
              .background(RoundedRectangle(cornerRadius: 20).strokeBorder())
            
            HStack{
                TextField("Password", text: $SignUpVM.password)
                   
                if(!SignUpVM.password.isEmpty){
                    Image(systemName: "person")
                }
            } .padding()
              .background(RoundedRectangle(cornerRadius: 20).strokeBorder())
            Button {
                
            } label: {
                Text("SignUp")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 25))
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 20))
            }
            
            

               
        }.padding()
            .frame(maxHeight:.infinity)
         
            .background(LinearGradient(colors: [Color.blue,Color.yellow], startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.5))
            .edgesIgnoringSafeArea(.top)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
