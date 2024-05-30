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
    private(set) var error: Error?
    private(set) var hasError = false
    private(set) var isLoading = false
    
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
            self.error = error
            self.hasError = true
        }
    }
}
