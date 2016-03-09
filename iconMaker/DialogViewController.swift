//
//  DialogViewController.swift
//  iconMaker
//
//  Created by Chen Yu-Chun on 2015/12/15.
//  Copyright © 2016年 Chen Yu-Chun. All rights reserved.
//

import Cocoa

class DialogViewController: NSViewController {

    @IBOutlet var m_txfFolderName: NSTextField!
    var m_strFolderName = ""
    var handleConfirmClosure: ((String) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.m_txfFolderName.stringValue = self.m_strFolderName
    }
    
    @IBAction func handleConfirm(sender: AnyObject) {
        if let block = handleConfirmClosure {
            block(self.m_txfFolderName.stringValue)
        }
        self.dismissViewController(self)
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
    }
}
