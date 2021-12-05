//
//  ContentView.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 4.12.2021.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var LoginVM = LoginViewModel()
    var body: some View {
        VStack(){
            
            Text("Gutenberg")
                .font(.largeTitle)
                .italic()
                .bold()
                .foregroundColor(Color.red)
                .frame(height:100,alignment: .top)
            HStack{
                TextField("Username", text: $LoginVM.username)
                if(!LoginVM.username.isEmpty){
                    Image(systemName: "person")
                }
              
            } .padding()
              .background(RoundedRectangle(cornerRadius: 20).strokeBorder())
            
            HStack{
                TextField("Username", text: $LoginVM.password)
                   
                if(!LoginVM.password.isEmpty){
                    Image(systemName: "person")
                }
            } .padding()
              .background(RoundedRectangle(cornerRadius: 20).strokeBorder())
            Button {
                
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 25))
                    .foregroundColor(Color.white)
                    .background(RoundedRectangle(cornerRadius: 20))
            }
            Button {
                
            } label: {
                Text("Forget Password")
                    .frame(maxWidth:.infinity,alignment: .trailing)
                    .padding(.top,1)
            }

            HStack{
                Rectangle().frame(height:2)
                Text("OR")
                Rectangle().frame(height:2)
            }
            Button {
                
            } label: {
                Text("Sign Up")
                    .font(.system(size: 20))
            }

            
           
           

                
                
               
        }.padding()
            .frame(maxHeight:.infinity)
         
            .background(LinearGradient(colors: [Color.blue,Color.yellow], startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.5))
            .edgesIgnoringSafeArea(.top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
