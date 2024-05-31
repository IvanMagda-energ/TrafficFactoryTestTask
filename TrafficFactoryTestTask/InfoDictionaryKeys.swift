//
//  InfoDictionaryKeys.swift
//  TrafficFactoryTestTask
//
//  Created by Ivan Magda on 30.05.2024.
//

import Foundation

enum InfoDictionaryKeys {
    static let bundleIdentifier: String = {
        guard let identifier = Bundle.main.bundleIdentifier else {
            fatalError("Plist file not found")
        }
        return identifier
    }()
}
