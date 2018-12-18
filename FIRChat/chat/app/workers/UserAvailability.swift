//
//  UserAvailability.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 29/11/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation
import FirebaseDatabase
import SwiftyJSON
class UserAvailability {
    static let shared = UserAvailability ()
    lazy var ref: DatabaseReference = {
        return Database.database().reference()
    }()
    
    let DB_NAME = "UserAvailability"
    
    enum Event {
        case userAdded, userRemoved
    }
    
    func registerAsOffline(with user: User, withCompletion c: @escaping (Bool, Error?)->()) {
        
        self.ref.child(self.DB_NAME).child(user.uid).removeValue() {
            (error, ref) in
            
            if let error = error {
                c(false, error)
            }else {
                c(true, nil)
            }
        }
    }
    
    func listOnlineUsers(withCompletion c: @escaping ([User]?, Error?)->Void) {
        self.ref.child(self.DB_NAME).queryOrderedByKey().observe(.value) { (snapshot) in
            if let results = snapshot.value as? NSDictionary {
                var users = results.compactMap({ (kv) ->User? in
                    return User.from(jsonObject: kv.value)
                })
                users = users.filter({ (u) -> Bool in
                    return u != App.shared.currentUser!
                })
                c(users, nil)
            } 
        }
    }
    
    func registerAsOnline(with user:User, UserwithCompletion c: @escaping (Bool, Error?)-> ()) {
        
        guard let userJSON = user.asJSONObject() else {
            fatalError("can't use user json")
        }
        
        self.ref.child(self.DB_NAME).child(user.uid).setValue(userJSON)  { (error, ref) in
            
            if let error = error {
                c(false, error)
            }else {
                c(true, nil)
            }
        }
    }
}
