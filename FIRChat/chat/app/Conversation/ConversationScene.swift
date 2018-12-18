//
//  ConversationScene.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 6/12/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation

protocol ConversationWorker {
    func getRecentMessages(between u1: User, u2: User, completion: @escaping ([Message]?, Error?)->() )
    func add(message: Message, withCompletion: (Bool, Error?)->Void)
}

protocol ConversationInteracter {
    func initializeChat(between me: User, and user: User)
    func send(message: Message)
}

protocol ConversationPresenter {
    func display(history: [Message])
    func display(_ error: Error)
    func displayLatest(message: Message)
}

protocol ConversationView {
    var alert: AppAlert? {get}
    var output: ConversationInteracter? {get}
    func display(messages: [Message])
    func append(message: Message)
}

class ConversationConfiguration {
    static let shared = ConversationConfiguration()
    private init() {}

    func configure(_ vc: ConversationViewController) {
        
        let presenter = DefaultConversationPresenter()
        presenter.output = vc
        let interacter = DefaultConversationInteracter()
        interacter.output = presenter
        vc.output = interacter
        
    }
}
