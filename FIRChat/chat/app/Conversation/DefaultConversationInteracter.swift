//
//  DefaultConversationInteracter.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 11/12/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation
import FirebaseDatabase

class DefaultConversationInteracter: ConversationInteracter {
    let ref = Database.database().reference().child("Conversations")
    var sessionRef: DatabaseReference?
    var output: ConversationPresenter?
    var CONV_SESSION_ID: String?
    var CONV_ID: String?
    let LAST_MESSAGES = 50
    
    var newTimestampKey: String {
        get {
            return "\(Int(Date().timeIntervalSince1970))"
        }
    }
    
    func initializeChat(between me: User, and user: User) {
        self.CONV_ID = [me.uid, user.uid].sorted().joined() // conversation id unique to two users
        self.CONV_SESSION_ID = self.newTimestampKey //session id unique to time of initiation
        self.sessionRef = ref.child("\(self.CONV_ID!)/\(self.CONV_SESSION_ID!)")
        
        ref.child(self.CONV_ID!).queryOrderedByKey().queryLimited(toLast: 50).observe(.value) { (snapshot) in
            var history = [Message]()
            
            for sessionSnapshot in snapshot.children.allObjects {
                let ss = sessionSnapshot as! DataSnapshot
                for mdSnapshot in ss.children.allObjects {
                    let md = mdSnapshot as! DataSnapshot
                    if let mjson = md.value {
                        if let message = Message.from(jsonObject: mjson) {
                            history.append(message)
                        }
                    }
                }
            }
            self.output?.display(history: history)
        }
    }
    
    func send(message: Message) {
        let json = message.asJSONObject()!
        //save a message to the session reference
        self.sessionRef?.child("\(Int(message.timestamp.timeIntervalSince1970))").setValue(json, withCompletionBlock: { (error, ref) in
            if let error = error {
                self.output?.display(error)
            }
        })
    }
    
    
}
