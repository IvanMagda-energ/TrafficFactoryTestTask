//
//  ContentViewModel.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 29.05.2024.
//

import Foundation
import Observation
import SwiftUI
import os

@Observable
final class ContentViewModel {
    // MARK: - Private properties
    private let logger = Logger(
        subsystem: InfoDictionaryKeys.bundleIdentifier,
        category: String(describing: ContentViewModel.self))
    private let requestManager: RequestManagerProtocol
        
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    // MARK: - properties
    private(set) var items = [Item]()
    private(set) var isLoading = false
    var error: ContentViewModelError?
    var hasError = false
    
    /// Fetches all items from a specified URL, updating the `items` property.
    func getAllItems() async {
        defer {
            withAnimation {
                isLoading = false
            }
        }
        do {
            withAnimation {
                isLoading = true
            }
            let dataUrlString = Constants.dataURL
            // The data is loading to fast, so we added some delay to imitate slowly loading data and to se appearing progress indicator.
            try await Task.sleep(for: .seconds(2))
            items = try await requestManager.initRequest(with: dataUrlString)
            
            logger.debug(#function)
        } catch {
            self.error = ContentViewModelError.failedToGetAllItems(error)
            self.hasError = true
        }
    }
}

extension ContentViewModel {
    enum ContentViewModelError: LocalizedError {
        case failedToGetAllItems(_ error: Error)
        
        public var errorDescription: String? {
            switch self {
            case .failedToGetAllItems:
                return "Error"
            }
        }
        
        public var failureReason: String? {
            switch self {
            case .failedToGetAllItems(let error):
                return "Failed to load all items with error: \(error.localizedDescription)"
            }
        }
        
        public var helpAnchor: String? {
            switch self {
            case .failedToGetAllItems:
                return "Please try again"
            }
        }
    }
}
