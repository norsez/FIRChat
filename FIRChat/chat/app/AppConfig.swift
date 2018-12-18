//
//  File.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 29/11/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import Foundation
import Whisper
protocol AppAlert {
    func alert(with text: String)
    func alert(error: Error)
}

class DefaultAlert: AppAlert {
    static let shared = DefaultAlert()
    
    func alert(error: Error) {
        let m = Murmur(title: "\(error.localizedDescription)", backgroundColor: UIColor.red.withAlphaComponent(0.8), titleColor: UIColor.yellow, font: UIFont.systemFont(ofSize: 14), action: nil)
        Whisper.show(whistle: m, action: WhistleAction.show(5))
        print(error)
    }
    
    func alert(with text: String) {
        let m = Murmur(title: text, backgroundColor: UIColor.white.withAlphaComponent(0.9), titleColor: UIColor.darkText, font: UIFont.systemFont(ofSize: 14), action: nil)
        Whisper.show(whistle: m, action: WhistleAction.show(5))
        print(text)
    }
    
}

class AppConfig {
    static let shared = AppConfig()
    
    func configure(_ c: UsersViewController) {
        
        c.currentUser = App.shared.currentUser
        
        let uin = DefaultUsersInteracter()
        c.output = uin
        
        let upres = DefaultPresenter()
        uin.output = upres
        
        upres.output = c
        
    }
    
    func configure(_ c: AppDelegate) {
        c.alert = DefaultAlert.shared
    }
    func configure(_ c: App) {
        c.alert = DefaultAlert.shared
    }
}
