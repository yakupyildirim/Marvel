//
//  ComicViewModel.swift
//  SwiftUICombine (iOS)
//
//  Created by Yakup Yıldırım on 2.12.2021.
//

import Foundation
import Combine
import CryptoKit


class ComiciewModel: ObservableObject{
    @Published var comics: [Comic] = []
    @Published var offset = 0
    var cancellationToken: AnyCancellable?
    var comicResponse = ComicResponse(data: nil)
    
    init(){
    }
}
    
extension ComiciewModel{
    
    func getComics(){
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = URLHelper.MD5(data: "\(ts)\(Credentials.privateKey)\(Credentials.publicKey)")
        
        let  queryItemValues = [
           URLQueryItem(name: "limit", value: "20"),
           URLQueryItem(name: "offset", value: "\(offset)"),
           URLQueryItem(name: "ts", value: ts),
           URLQueryItem(name: "apikey", value: Credentials.publicKey),
           URLQueryItem(name: "hash", value: hash)
        ]
        
        cancellationToken = MarvelDB.request(.comicPath, queryItemValues, comicResponse)
            .mapError({(error)-> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: {
                _ in
            }, receiveValue: {
                let comicValue = $0.data.comics
                DispatchQueue.main.async {
                    self.comics.append(contentsOf: comicValue!)
                }
             
            })
    }
}
