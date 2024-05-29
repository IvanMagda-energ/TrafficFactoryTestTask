//
//  ApiManager.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 29.05.2024.
//

import Foundation

protocol APIManagerProtocol {
    func initRequest(with url: URL) async throws -> Data
    
}

class APIManager: APIManagerProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func initRequest(with url: URL) async throws -> Data {
        let (data, response) = try await urlSession.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else { throw NetworkError.invalidServerResponse }
        return data
    }
}
