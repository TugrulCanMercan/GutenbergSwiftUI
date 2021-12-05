//
//  GutenbergApp.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 4.12.2021.
//

import SwiftUI

@main
struct GutenbergApp: App {
    @StateObject var auth = Auth()
    
    var body: some Scene {
        WindowGroup {
            if(auth.authStatus){
                HomeView()
            }else{
                LoginView()
            }
        }
    }
}
