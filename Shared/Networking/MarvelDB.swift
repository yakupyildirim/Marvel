//
//  MarvelDB.swift
//  SwiftUICombine (iOS)
//
//  Created by Yakup Yıldırım on 2.12.2021.
//

import Foundation
import Combine

enum MarvelDB{
    static let apiClient = ApiClient()
    static let baseURL = URL(string: "https://gateway.marvel.com:443/v1/public")!
}


enum APIPath: String{
    case charactersPath = "characters"
    case comicPath = "comics"
}


extension MarvelDB{
    static func request<T: Decodable>(_ path: APIPath, _ queryItems: [URLQueryItem]?, _ type: T) -> AnyPublisher<T, Error>{
        guard var components = URLComponents(url: baseURL.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true)
        else{
            fatalError("Couldn't create URLComponents")
        }
        
        if queryItems != nil
        {
          components.queryItems = queryItems
        }
            
        let request = URLRequest(url: components.url!)
        
        return apiClient.run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
