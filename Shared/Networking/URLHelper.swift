//
//  URLHelper.swift
//  SwiftUICombine (iOS)
//
//  Created by Yakup Yıldırım on 3.12.2021.
//

import Foundation
import CryptoKit

struct URLHelper{
    
  static func MD5(data: String)->String{
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map{
            String(format: "%02hhx", $0)
        }
        .joined()
    }
    
}
