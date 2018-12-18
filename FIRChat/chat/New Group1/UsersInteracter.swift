//
//  UsersInteracter.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 29/11/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation

class DefaultUsersInteracter: UsersInteracter {
    var output: UsersPresenter?
    var availability = UserAvailability.shared
    
    var alert: AppAlert?
    
    func listUsers() {
        self.availability.listOnlineUsers { (users, error) in
            if let error = error {
                self.alert?.alert(error: error)
            }else if let users = users {
                self.output?.present(users: users)
            }
            
            if let currentUser = App.shared.currentUser {
                self.output?.present(currentUser: currentUser)
            }
        }
    }
    
    func openConversation(between currentUser: User, user: User) {
        self.output?.openConversation(between: currentUser, user: user)
    }
}
