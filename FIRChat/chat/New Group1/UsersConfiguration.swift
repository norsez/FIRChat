//
//  UsersConfiguration.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 29/11/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation

protocol UsersInteracter {
    var output: UsersPresenter? { get }
    func listUsers()
    func openConversation(between currentUser: User, user: User)
}

protocol UsersPresenter {
    var output: UsersView? { get }
    func present(users: [User])
    func present(currentUser: User)
    func openConversation(between currentUser: User, user: User) 
}

protocol UsersView {
    var output: UsersInteracter? { get }
    func update(userList: [User])
    func update(currentUser: User)
//    func openConversation(between currentUser: User, user: User)
}
