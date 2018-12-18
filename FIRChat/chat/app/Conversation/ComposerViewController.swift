//
//  ComposerViewController.swift
//  FIRChat
//
//  Created by Norsez Orankijanan on 13/12/2561 BE.
//  Copyright © 2561 Bluedot. All rights reserved.
//

import UIKit

class ComposerViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var textEditor: UITextView!
    var didPressSend: ((String)->())?
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    
}
