//
//  Character.swift
//  SwiftUICombine
//
//  Created by Yakup Yıldırım on 30.11.2021.
//

import Foundation

struct CharacterResponse: Codable{
    let data: CharacterData!
   
    enum CodingKeys: String, CodingKey{
        case data
    }
}


struct CharacterData: Codable{
    let characters: [Character]!
   
    enum CodingKeys: String, CodingKey{
        case characters = "results"
    }
}

