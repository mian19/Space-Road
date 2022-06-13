//
//  FirebaseManager.swift
//  Space Road
//
//  Created by Kyzu on 11.06.22.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase

class FireBaseManager {
    static func checkUserAuth() -> Int {
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

//@objc func logout() {
//    do {
//        try Auth.auth().signOut()
//        KeychainManager.shared.delete()
//        appCoordinator?.toRegistrationScreen()
//    } catch {
//        print(error)
//    }
//}
