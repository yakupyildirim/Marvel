//
//  ImageCache.swift
//  Marvel (iOS)
//
//  Created by Yakup Yıldırım on 5.12.2021.
//

import Foundation
import UIKit

protocol ImageCache{
    subscript(_ url:URL)->UIImage?{get set}
}

struct TempImageCache:ImageCache{
    private let cache:NSCache<NSURL, UIImage>={
        let cache = NSCache<NSURL,UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    subscript(url: URL) -> UIImage? {
        get{
            cache.object(forKey: url as NSURL)
        }
        set{
            newValue == nil ? cache.removeObject(forKey: url as NSURL): cache.setObject(newValue!, forKey: url as NSURL)
        }
    }
}
