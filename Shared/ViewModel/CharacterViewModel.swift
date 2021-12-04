//
//  CharacterViewModel.swift
//  SwiftUICombine (iOS)
//
//  Created by Yakup Yıldırım on 2.12.2021.
//

import Foundation
import Combine
import CryptoKit

class CharacterViewModel: ObservableObject{
    @Published var searchQuery = ""
    @Published var characters: [Character]? = []
    
    var searchCancellable:AnyCancellable? = nil
    var cancellationToken: AnyCancellable?
    var characterResponse = CharacterResponse(data: nil)
    
    init(){
        searchCancellable = $searchQuery
            .removeDuplicates()
             // it wiill wait for 0.5 after user ends typing
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { value in
                if value == "" {
                    self.characters = nil
                }
                else{
                    self.getCharacters()
                }
            })
    }
}

extension CharacterViewModel{
    
    func getCharacters(){
        
        let ts = String(Date().timeIntervalSince1970)
        let hash = URLHelper.MD5(data: "\(ts)\(Credentials.privateKey)\(Credentials.publicKey)")
        
        let  queryItemValues = [
           URLQueryItem(name: "nameStartsWith", value: searchQuery.replacingOccurrences(of: " ", with: "%20")),
           URLQueryItem(name: "ts", value: ts),
           URLQueryItem(name: "apikey", value: Credentials.publicKey),
           URLQueryItem(name: "hash", value: hash)
        ]
        
        cancellationToken = MarvelDB.request(.charactersPath, queryItemValues, characterResponse)
            .mapError({(error)-> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: {
                _ in
            }, receiveValue: {
                self.characters = $0.data.characters
            })
    }
}
