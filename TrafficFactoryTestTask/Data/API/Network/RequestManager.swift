//
//  RequestManager.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 29.05.2024.
//

import Foundation

protocol RequestManagerProtocol {
    var apiManager: APIManagerProtocol { get }
    var parser: DataParserProtocol { get }
    func initRequest<T: Decodable>(with urlString: String) async throws -> T
}


class RequestManager: RequestManagerProtocol {
    let apiManager: APIManagerProtocol
    
    init(
        apiManager: APIManagerProtocol = APIManager()
    ) {
        self.apiManager = apiManager
    }
    
    func initRequest<T: Decodable>(with urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        let data = try await apiManager.initRequest(with: url)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}

// MARK: - Returns Data Parser
extension RequestManagerProtocol {
    var parser: DataParserProtocol {
        return DataParser()
    }
}
