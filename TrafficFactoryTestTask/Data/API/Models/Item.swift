//
//  Item.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 29.05.2024.
//

import Foundation

struct Item {
    var id = UUID()
    var title: String
    var description: String
    var imageURL: String
}

// MARK: - Codable
extension Item: Codable {
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case imageURL
    }
}

// MARK: - Hashable
extension Item: Hashable {}


// MARK: - Identifiable
extension Item: Identifiable {}
