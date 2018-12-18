//
//  ViewController.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 29/11/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let list = [["name": "John", "lastname": "Appleseed"]]
        let ref = Database.database().reference()
        
        //ref.child("test/test_list").setValue(list)
        
        ref.child("test/test_list").observe(.value) { (snapshot) in
            print("\(snapshot.value)")
        }
    }


}

