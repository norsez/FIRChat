//
//  ConversationViewController.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 7/12/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import UIKit

class MeCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}

class TheirCell: UITableViewCell {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
}

class ConversationViewController: UITableViewController, ConversationView {
    var alert: AppAlert?
    
    let THEIR_CELL = "THEIR_CELL"
    let MY_CELL = "MY_CELL"
    
    var output: ConversationInteracter?
    var currentUser: User?
    var user: User?
    var messages: [Message]?
    
    var sendButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConversationConfiguration.shared.configure(self)
        
        self.title = self.user?.displayName ?? "Anonymous"
        self.output?.initializeChat(between: self.currentUser!, and: self.user!)
        self.sendButton = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(didPressSend(_:)))
        self.navigationItem.rightBarButtonItem = self.sendButton
        
    }
    
    @objc func didPressSend(_ sender: Any){
        let ctrl = UIAlertController(title: "Send Message", message: nil, preferredStyle: .alert)
        ctrl.addTextField { (tf) in
            tf.placeholder = "Type something"
        }
        ctrl.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            if let textInput = ctrl.textFields?.first,
                let text = textInput.text {
                if text.count > 0 {
                    let m = Message(with: self.currentUser!, message: text, receiver: self.user!)
                    self.output?.send(message: m)
                }
            }
        }))
        
        self.present(ctrl, animated: true, completion: nil)
    }
    
    
    func display(messages: [Message]) {
        self.messages = messages
        self.tableView.reloadData()
        if messages.count > 0 {
            self.tableView.scrollToRow(at: IndexPath(row: messages.count-1, section: 0), at: .bottom, animated: true)
        }
    }
    
    func append(message: Message) {
        self.messages?.append(message)
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let m = (self.messages?[indexPath.row])!
        let cellIdentifier = (m.sender == self.currentUser) ? MY_CELL : THEIR_CELL
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if let cell = cell as? MeCell {
            cell.nameLabel.text = self.currentUser?.displayName
            cell.messageLabel.text = m.message
        }else if let cell = cell as? TheirCell {
            cell.nameLabel.text = self.user?.displayName
            cell.messageLabel.text = m.message
        }
        
        
        return cell!
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
