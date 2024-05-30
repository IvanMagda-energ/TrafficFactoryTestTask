//
//  Cache.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 30.05.2024.
//

import Foundation
import SwiftUI
import os
import Observation

@Observable
final class Cache {
    /// The shared singleton instance of the `Cache` class.
    static let shared = Cache()
    
    /// The underlying `NSCache` instance used for storing images.
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Methods
    /// This method saves the provided `UIImage` to the cache with the specified key.
    /// - Parameters:
    ///   - object: The `UIImage` to store in the cache.
    ///   - key: The key with which to associate the image in the cache as `String`
    func set(object: UIImage, for key: String) {
        cache.setObject(object, forKey: NSString(string: key))
    }
    
    /// This method fetches a `UIImage` from the cache and wraps it in a SwiftUI `Image`.
    /// - Parameter key: The key associated with the image in the cache as `String`
    /// - Returns: An optional `Image` if an image is found in the cache, or `nil` if no image exists for the given key.
    func getObject(for key: String) -> Image? {
        guard let uiImage = cache.object(forKey: NSString(string: key)) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }
}
