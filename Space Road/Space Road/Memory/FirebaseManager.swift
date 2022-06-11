//
//  FirebaseManager.swift
//  Space Road
//
//  Created by Kyzu on 11.06.22.
//

import Foundation
import FirebaseAuth
import FirebaseCore

class FireBaseManager {
    private static func checkUserAuth() -> Int {
        var checkResult: Int!
        Auth.auth().addStateDidChangeListener { (_, user ) in
            if user == nil {
                checkResult = 0
            } else {
                checkResult = 1
            }
        }
        return checkResult
    }
}
