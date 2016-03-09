//
//  AppDelegate.swift
//  iconMaker
//
//  Created by Chen Yu-Chun on 2015/12/14.
//  Copyright © 2015年 Chen Yu-Chun. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var m_aboutWindowController : AboutWindowController!

    var completeLoadImage: ((NSImage) -> ())?
    @IBAction func handleAboutEvent(sender: AnyObject) {
        let storyboard : NSStoryboard = NSStoryboard(name: "Main", bundle: nil)
        self.m_aboutWindowController = storyboard.instantiateControllerWithIdentifier("aboutWindow") as! AboutWindowController
        self.m_aboutWindowController.showWindow(self)
    }
    
    @IBAction func openFile(sender: AnyObject) {
        let fileTypes = ["jpg","jpeg","png"]
        let openDlg = NSOpenPanel()
        openDlg.allowsMultipleSelection = false
        openDlg.canChooseDirectories = false
        openDlg.canChooseFiles = true
        openDlg.floatingPanel = true
        openDlg.allowedFileTypes = fileTypes
        openDlg.beginWithCompletionHandler { (result) -> Void in
            if result == 1 {
                let url:NSURL = openDlg.URLs[0]
                let image:NSImage = NSImage(contentsOfURL: url)!
                self.completeLoadImage!(image)
            }
            
        }
    }


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}

