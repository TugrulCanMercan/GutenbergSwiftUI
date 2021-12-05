//
//  LoginRequestModel.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 4.12.2021.
//

import Foundation

struct getTokenReq: Codable {
    let user: User
}

// MARK: - User
struct User: Codable {
    let username, password: String
}
