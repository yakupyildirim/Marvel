//
//  Comic.swift
//  SwiftUICombine (iOS)
//
//  Created by Yakup Yıldırım on 2.12.2021.
//

import Foundation

struct Comic: Identifiable, Codable{
    var id = UUID()
    let comicId :Int
    let title: String
    let description: String?
    let thumbnail: [String:String]
    let urls: [[String:String]]
    
    enum CodingKeys: String, CodingKey{
        case comicId  = "id"
        case title
        case description
        case thumbnail
        case urls
    }
}
