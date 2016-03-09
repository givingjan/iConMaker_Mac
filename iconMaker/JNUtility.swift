//
//  JNUtility.swift
//  iconMaker
//
//  Created by Chen Yu-Chun on 2015/12/14.
//  Copyright © 2015年 Chen Yu-Chun. All rights reserved.
//

import Cocoa

public class JNUtility: NSObject {
    
     class func showAlertWithTitle(title:String, message:String, completion:(Void)->Void) {
        let alert = NSAlert()
        alert.addButtonWithTitle("YES")
        alert.addButtonWithTitle("NO")
        alert.messageText = title
        alert.informativeText = message
        
        if alert.runModal() == NSAlertFirstButtonReturn {
            print("OK")
            completion()
            
        }
    }
    
    class func showOneButtonAlertWithTitle(title:String, message:String, completion:(Void)->Void) {
        let alert = NSAlert()
        alert.addButtonWithTitle("OK")
        alert.messageText = title
        alert.informativeText = message
        
        if alert.runModal() == NSAlertFirstButtonReturn {
            print("OK")
            completion()
        }
    }

}
