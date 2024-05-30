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
    mutating func loadAndCacheImage(from imageUrlString: String) async {
        self.getImage(for: imageUrlString)
        do {
            let imageData = try await requestManager.getData(from: imageUrlString)
            
            if let uiImage = UIImage(data: imageData) {
                cache.set(object: uiImage, for: imageUrlString)
            }
            logger.debug("\(#function) url: \(imageUrlString)")
        } catch {
            return
        }
    }
    
    mutating func getImage(for imageUrlString: String) {
        self.image = cache.getObject(for: imageUrlString)
    }
}
