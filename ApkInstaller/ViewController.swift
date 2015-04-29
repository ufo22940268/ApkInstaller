//
//  ViewController.swift
//  ApkInstaller
//
//  Created by ccheng on 4/28/15.
//  Copyright (c) 2015 Frank Cheng. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var selectApk: NSButton!
    @IBOutlet weak var scrollView: NSScrollView!
    
    var apkPath:String?
    var devices:[Device]?
    
    @IBOutlet weak var table: NSTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showDevicesView()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    func showDevicesView() {
        selectApk.hidden = true
        devices = CmdUtil.getDevices()
        scrollView.hidden = false
        table.reloadData()
    }
    
    @IBAction func onClick(sender: AnyObject) {
        var openPanel = NSOpenPanel();
        openPanel.beginWithCompletionHandler{ (result) -> Void in
            if result == NSFileHandlingPanelOKButton {
                self.apkPath = openPanel.URL?.path
                self.showDevicesView()
            }
        }
    }
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        if let count = devices?.count {
            return count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cell = tableView.makeViewWithIdentifier("text", owner: self) as!
        NSTableCellView
        if let d = devices?[row] {
            cell.textField?.stringValue = d.id
        }
        return cell
    }
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        if let device = devices?[table.selectedRow] {
            var alert = NSAlert();
            alert.messageText = "确认安装应用到\(device.id)吗？"
            alert.addButtonWithTitle("确定")
            alert.addButtonWithTitle("取消")
            var int = alert.runModal()
            if int == 1000 {
                println("ok \(int)")
            } else {
                println("cancel \(int)")
            }
        }
    }
    
}