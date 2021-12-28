//
//  SearchBook.swift
//  Gutenberg
//
//  Created by Tuğrulcan on 26.12.2021.
//

import Foundation
struct SearchBook:Codable,Hashable{
    var title:String
    var subtitle:String
    var extra:String
    var link:String
    var image:String
}
