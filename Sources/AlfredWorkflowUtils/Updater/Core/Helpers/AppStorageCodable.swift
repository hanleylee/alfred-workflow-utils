//
//  File.swift
//
//
//  Created by Hanley Lee on 2024/11/26.
//

import Foundation

@propertyWrapper
struct AppStorageCodable<Value: Codable> {
    private let key: String
    private let store: UserDefaults

    init(_ key: String, store: UserDefaults = .standard) {
        self.key = key
        self.store = store
    }

    var wrappedValue: Value? {
        get {
            guard let jsonData = store.data(forKey: key) else { return nil }
            return try? JSONDecoder().decode(Value.self, from: jsonData)
        }
        set {
            if let newValue = newValue {
                if let jsonData = try? JSONEncoder().encode(newValue) {
                    store.set(jsonData, forKey: key)
                }
            } else {
                store.removeObject(forKey: key)
            }
        }
    }
}
