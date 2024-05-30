//
//  ItemImageViewModel.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 30.05.2024.
//

import Foundation
import SwiftUI
import os

struct ItemImageViewModel {
    // MARK: - Private properties
    private let logger = Logger(
        subsystem: InfoDictionaryKeys.bundleIdentifier,
        category: String(describing: ItemImageViewModel.self))
    private let cache: Cache
    private let requestManager: RequestManagerProtocol
    
    // MARK: - Properties
    private(set) var image: Image?
    
    // MARK: - Initialiser
    init(cache: Cache = Cache.shared, requestManager: RequestManagerProtocol = RequestManager()) {
        self.cache = cache
        self.requestManager = requestManager
    }
    
    // MARK: - Methods
    /// Fetch and caches the image from a given URL string.
    /// - Parameter imageUrlString: The URL of the image to load as `String`.
    mutating func fetchImageAndCaches(from imageUrlString: String) async {
        // Fetch image from network and update cache
        do {
            let imageData = try await requestManager.getData(from: imageUrlString)
            // The data is loading to fast, so we added some delay to imitate slowly loading data and to se appearing progress indicator.
            try? await Task.sleep(for: .seconds(2))
            
            if let uiImage = UIImage(data: imageData) {
                cache.set(object: uiImage, for: imageUrlString)
                self.image = Image(uiImage: uiImage)
                logger.debug("Load image from network and update cache")
            }
        } catch {
            return
        }
    }
    
    /// Load image from cache.
    /// - Parameter imageUrlString: The URL of the image to load as `String`.
    mutating func loadImage(from imageUrlString: String) {
        // Attempt to get the image from the cache
        if let cachedImage = cache.getObject(for: imageUrlString) {
            self.image = cachedImage
            logger.debug("Image loaded from cache for URL: \(imageUrlString)")
            return
        }
    }
}
