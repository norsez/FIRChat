//
//  ConversationPresenter.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 12/12/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation
class DefaultConversationPresenter: ConversationPresenter {
    var output: ConversationView?
    
    func display(history: [Message]) {
        self.output?.display(messages: history)
    }
    
    func display(_ error: Error) {
        
    }
    
    func displayLatest(message: Message) {
            self.output?.append(message: message)
    }
    
    
}
