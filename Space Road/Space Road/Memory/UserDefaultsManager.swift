//
//  UserDefaultsManager.swift
//  Space Road
//
//  Created by Kyzu on 14.06.22.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    func saveSettings() {
        func save(settings: Settings) {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(settings)
                UserDefaults.standard.set(data, forKey: "settings")
            } catch {
                print(error)
            }
        }
    }
    
    func getSettings() -> Settings? {
        var settings: Settings?
        guard let data = UserDefaults.standard.data(forKey: "settings") else {
                return nil
            }
        do {
            let decoder = JSONDecoder()
            settings = try decoder.decode(Settings.self, from: data)
        } catch {
            print(error)
        }
        return settings
    }
}
