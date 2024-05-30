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
    
    // MARK: - Observed properties
    private(set) var items = [Item]()
    private(set) var error: Error?
    private(set) var hasError = false
    private(set) var isLoading = true
    
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
            try await Task.sleep(for: .seconds(1))
            items = try await requestManager.initRequest(with: dataUrlString)
            
            logger.debug(#function)
        } catch {
            self.error = error
            self.hasError = true
        }
    }
}
