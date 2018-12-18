//
//  UsersPresenter.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 29/11/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation

class DefaultPresenter: UsersPresenter {
    var output: UsersView?
    
    func present(users: [User]) {
        self.output?.update(userList: users)
    }
    
    func present(currentUser: User) {
        self.output?.update(currentUser: currentUser)
    }
    
    func openConversation(between currentUser: User, user: User) {
        //self.output?.openConversation(between: user, user: user)
    }
    
}
