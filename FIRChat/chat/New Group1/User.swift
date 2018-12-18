//
//  User.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 30/11/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation
import SwiftyJSON



struct User: Codable, Equatable {
    
    let uid: String
    let displayName: String
    
    init(with uid: String, displayName: String) {
        self.uid = uid
        self.displayName = displayName
    }
    
    func asJSONObject() -> Any? {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            return jsonObject
        }catch {
            return nil
        }
    }
    
    static func from(jsonObject: Any) -> User? {
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            let decode = JSONDecoder()
            let user = try decode.decode(User.self, from: data)
            return user
        }catch {
            print(error)
            return nil
        }
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.uid == rhs.uid
    }
    
}
