//
//  Book.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 26.12.2021.
//

import Foundation

struct Book : Codable,Hashable{
    var bookId:String
    var title:String
    var authors:String
    var image:String
}
