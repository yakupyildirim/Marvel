//
//  Character.swift
//  SwiftUICombine (iOS)
//
//  Created by Yakup Yıldırım on 2.12.2021.
//

import Foundation

struct Character: Codable, Identifiable {
    var id = UUID()
    let characterId: Int
    let name: String
    let description: String?
    let thumbnail: [String:String]
    let urls: [[String:String]]
    
    enum CodingKeys: String, CodingKey {
        case characterId = "id"
        case name
        case description
        case thumbnail
        case urls
    }
}
