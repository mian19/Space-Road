//
//  KeychainManager.swift
//  Space Road
//
//  Created by Kyzu on 11.06.22.
//

import Foundation
import UIKit
import KeychainSwift
class KeychainManager {
    static let shared = KeychainManager()
    func save(_ user: User) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(user)
            KeychainSwift().set(data, forKey: "currentUser")
        } catch {
            print(error)
        }
    }
    func get() -> User? {
        do {
            let decoder = JSONDecoder()
            if let data = KeychainSwift().getData("currentUser") {
                let user = try decoder.decode(User.self, from: data)
                return user
            }
        } catch {
            print(error)
        }
        return nil
    }
    func delete() {
        KeychainSwift().delete("currentUser")
        KeychainSwift().clear()
    }
}
