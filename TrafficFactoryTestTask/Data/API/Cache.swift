//
//  Cache.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 30.05.2024.
//

import Foundation
import SwiftUI
import os

final class Cache {
    static let shared = Cache()
    
    private let cache = NSCache<NSString, UIImage>()
    
    func set(object: UIImage, for key: String) {
        cache.setObject(object, forKey: NSString(string: key))
    }
    
    func getObject(for key: String) -> Image? {
        guard let uiImage = cache.object(forKey: NSString(string: key)) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}
