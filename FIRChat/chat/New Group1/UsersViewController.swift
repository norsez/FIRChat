//
//  UsersViewController.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 29/11/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import UIKit
class UsersViewController: UITableViewController, UsersView {
    
    var currentUser: User?
    var selectedUser: User?
    var userList = [User]()
    let CELL_USER = "CELL_USER"
    var output: UsersInteracter?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        AppConfig.shared.configure(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.output?.listUsers()
    }
    
    func update(userList: [User]) {
        self.userList = userList
        self.tableView.reloadData()
    }
    
    func update(currentUser: User) {
        self.currentUser = currentUser
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userList.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.currentUser?.displayName
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.CELL_USER, for: indexPath)
        
        let name = self.userList [indexPath.row].displayName
        cell.textLabel?.text = name
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueName = segue.identifier {
            if segueName == "conversation" {
                if let ctrl = segue.destination as? ConversationViewController {
                    
                    let user = self.userList[self.tableView.indexPathForSelectedRow!.row]
                    self.selectedUser = user
                    ctrl.currentUser = self.currentUser!
                    ctrl.user = self.selectedUser!
                }
            }
        }
    }
    
}
