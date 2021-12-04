//
//  ImageCacheKey.swift
//  Marvel (iOS)
//
//  Created by Yakup Yıldırım on 5.12.2021.
//

import Foundation
import SwiftUI

struct ImageCacheKey: EnvironmentKey{
    static let defaultValue: ImageCache = TempImageCache()
}

extension EnvironmentValues{
    var imageCache: ImageCache{
        get{self[ImageCacheKey.self]}
        set{self[ImageCacheKey.self] = newValue}
    }
}
