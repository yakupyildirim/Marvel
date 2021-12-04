//
//  Character.swift
//  SwiftUICombine
//
//  Created by Yakup Yıldırım on 30.11.2021.
//

import Foundation

struct ComicResponse: Codable{
    let data: ComicData!
    
    enum CodingKeys: String, CodingKey{
        case data
    }
}

struct ComicData: Codable{
    let comics: [Comic]!
   
    enum CodingKeys: String, CodingKey{
        case comics = "results"
    }
}

