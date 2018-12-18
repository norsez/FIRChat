//
//  App.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 29/11/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation
import Firebase


class App {
    static let shared = App()
    var currentUser: User?
    var alert: AppAlert?
    func registerAsOnline() {
        
        Auth.auth().signInAnonymously { (result, error) in
            if let error = error {
                self.alert?.alert(error: error)
            }
            
            if let user = result?.user {
                let uid = user.uid
                self.currentUser = User(with: uid, displayName: String(uid.prefix(8)))
                UserAvailability.shared.registerAsOnline(with: self.currentUser!) { (success, error) in
                    if success {
                        self.alert?.alert(with: "logged in user id: \(uid)")
                    }
                    if let error = error {
                        self.alert?.alert(error: error)
                    }
                }
            }
        }
    }
    
    func registerAsOfflineUser() {
        guard let user = self.currentUser else {
            print("no user to log off with")
            return 
        }
        UserAvailability.shared.registerAsOffline(with: user) { (success, error) in
            if let error = error {
                self.alert?.alert(error: error)
            }else {
                print("logged off")
            }
        }
    }
}


