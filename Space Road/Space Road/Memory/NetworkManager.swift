//
//  NetworkManager.swift
//  Space Road
//
//  Created by Kyzu on 12.06.22.
//

import Foundation
import Network

class NetworkManager {
    static func monitoringNetwork() -> Bool {
            var isNetworkEnable = true
            let monitor = NWPathMonitor()
        DispatchQueue.main.async {
            monitor.pathUpdateHandler = { path in
                if path.status != .satisfied {
                    isNetworkEnable = false
                }
            }
        }
        return isNetworkEnable
    }
}
