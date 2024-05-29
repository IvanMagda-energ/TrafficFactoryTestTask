//
//  ContentViewModel.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 29.05.2024.
//

import Foundation
import Observation
import SwiftUI

@Observable
final class ContentViewModel {
    private let requestManager: RequestManagerProtocol
    
    init(requestManager: RequestManagerProtocol = RequestManager()) {
        self.requestManager = requestManager
    }
    
    var items = [Item]()
    var error: Error?
    var hasError = false
    var isLoading = true
    
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
            debugPrint(items)
        } catch {
            self.error = error
            self.hasError = true
        }
    }
}
