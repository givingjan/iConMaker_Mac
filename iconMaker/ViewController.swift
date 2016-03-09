//
//  ViewController.swift
//  iconMaker
//
//  Created by Chen Yu-Chun on 2015/12/14.
//  Copyright © 2015年 Chen Yu-Chun. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {
    // MARK:Constant Define
    let kiOS:String = "iOS"
    let kAndroid:String = "Android"

    // MARK:Property
    var m_strFloderPath:String = ""
    var m_imgLogo:NSImage!
    @IBOutlet var m_imgAdd: NSImageView!
    @IBOutlet var m_btiOS: NSButton!
    @IBOutlet var m_btAndroid: NSButton!
    @IBOutlet var m_vDropView: DropView!
    // MARK:Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    func initView() {
        
        // init DropView
        self.m_vDropView.initDrop();
        self.m_vDropView.getimageblock = {(image:NSImage!) -> Void in
            print("get new image");
            self.didReceiveNewImageLogo(image)
        }
        
        // init enabled status.
        self.m_btiOS.enabled = false
        self.m_btAndroid.enabled = false
        
        // for load image from menubar.
        let delegate:AppDelegate = NSApplication.sharedApplication().delegate as! AppDelegate
        delegate.completeLoadImage = {
            (image) -> Void in
            self.didReceiveNewImageLogo(image)
        }
    }
    
    
    // MARK: Privete Method
    override func prepareForSegue(segue: NSStoryboardSegue, sender: AnyObject?) {
        let segueId:String = segue.identifier!
        
        let dvc:DialogViewController = segue.destinationController as! DialogViewController
        dvc.m_strFolderName = ""
        
        func doMakeIcon(){
            var aryDatalist:Array<CGFloat> = []
            // iOS
            if segueId == self.kiOS {
                print("iOS")
                aryDatalist = [29.0,58.0,87.0,40.0,80.0,120.0,60.0,180.0]
            }
                // Android
            else if segueId == self.kAndroid {
                print("Android")
                aryDatalist = [36.0,48.0,64.0,72.0,96.0,144.0,192.0,512.0]
            }
            
            for size in aryDatalist {
                self.saveImage(size)
            }
            
            JNUtility.showOneButtonAlertWithTitle("ICON Build Success", message: "Your icons's folder now is on the desktop") { (Void) -> Void in
            }
        }
        
        dvc.handleConfirmClosure = {
            (strFolderName) -> Void in
            
            // Create Folder
            if self.createFolder(strFolderName) == true {
                doMakeIcon()
            }
            else {
                JNUtility.showAlertWithTitle("Warning", message: "\"\(strFolderName)\" ,this folder name already exist, do you want to replace it ?", completion: {
                    doMakeIcon()
                })
            }
        }
    }

    func didReceiveNewImageLogo(image:NSImage){
        self.m_imgLogo = image
        self.m_imgAdd.hidden = true;
        self.m_btiOS.enabled = true;
        self.m_btAndroid.enabled = true;
    }
    
    func resize(image: NSImage, w: CGFloat, h: CGFloat) -> NSImage {
        let destSize = NSMakeSize(w, h)
        let newImage = NSImage(size: destSize)
        newImage.lockFocus() // make the drawing appear on the newImage instead of on the screen
        image.drawInRect(NSMakeRect(0, 0, destSize.width, destSize.height), fromRect: NSMakeRect(0, 0, image.size.width, image.size.height), operation: NSCompositingOperation.CompositeSourceOver, fraction: CGFloat(1))
        newImage.unlockFocus() // unlock after finished drawing.
        
        return NSImage(data: newImage.TIFFRepresentation!)!
    }
    
    func saveImage(size:CGFloat) {
        let image = resize(self.m_imgLogo!, w: size, h: size)
        let strImgName = "icon_\(size.string(0))x\(size.string(0))"
        let filePathToWrite = "\(self.m_strFloderPath)/\(strImgName).png"
        var imageData = image.TIFFRepresentation
        let imageRep = NSBitmapImageRep(data: imageData!)
        let imageProps = [NSImageCompressionFactor:NSNumber(float: 1.0)]
        imageData = imageRep!.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: imageProps)
        
        imageData?.writeToFile(filePathToWrite, atomically: false)
    }

    
    func createFolder(strFolderName:String) ->Bool {
        let manager = NSFileManager.defaultManager()
        let paths = NSSearchPathForDirectoriesInDomains(.DesktopDirectory, .UserDomainMask, true)[0] as String
        m_strFloderPath = "\(paths)/\(strFolderName)"
        do {
            if manager.isReadableFileAtPath(m_strFloderPath) {
                print("already exist")
                return false
            }
            try manager.createDirectoryAtPath(m_strFloderPath, withIntermediateDirectories: true, attributes: nil)
            return true
        } catch {
            print("error")
            return false
        }
    }
}

