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
    
    static let shared = FireBaseManager()
    
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
    
    func getUserRecord(completion: @escaping (Int) -> Void) {
        let nick = KeychainManager().get()?.nick ?? ""
        DispatchQueue.main.async {
            let ref = Database.database().reference().child("records")
            ref.child(nick).getData(completion: {(error, snapshot) in
                guard error == nil else {
                    return
                }
                if let data = snapshot.value as? [String: Int] {
                    completion(data["record"]!)
                }
            })
        }
    }
    
    func getWorldRecords(completion: @escaping ([String: Int]) -> Void) {
        DispatchQueue.main.async {
            let ref = Database.database().reference().child("worldRecords")
            ref.getData(completion: {( error, snapshot) in
                guard error == nil else {
                    return
                }
                if let data = snapshot.value as? [String: Int] {
                    completion(data)
                }
            })
        }
    }
}
