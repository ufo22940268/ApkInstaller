//
//  ViewController.swift
//  ApkInstaller
//
//  Created by ccheng on 4/28/15.
//  Copyright (c) 2015 Frank Cheng. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onClick(sender: AnyObject) {
        var openPanel = NSOpenPanel();
        openPanel.beginWithCompletionHandler{ (result) -> Void in
            if result == NSFileHandlingPanelOKButton {
                var apkPath = openPanel.URL
                if var path = apkPath?.path {
                    CmdUtil.installApk(path)
                }
            }
        }
    }

}

