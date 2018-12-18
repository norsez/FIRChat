//
//  Message.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 12/12/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation

struct Message: Codable, Equatable {
    let timestamp: Date
    let sender: User
    let receiver: User
    let message: String
    
    
    init(with sender: User, message: String, receiver: User) {
        self.timestamp = Date()
        self.sender = sender
        self.message = message
        self.receiver = receiver
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
    
    static func from(jsonObject: Any) -> Message? {
        do {
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [])
            let decode = JSONDecoder()
            let message = try decode.decode(Message.self, from: data)
            return message
        }catch {
            return nil
        }
    }
    
    static func == (lhs: Message, rhs: Message) -> Bool {
        return lhs.timestamp == rhs.timestamp
    }
    
}
