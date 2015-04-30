//
//  CmdUtil.swift
//  test
//
//  Created by ccheng on 4/28/15.
//  Copyright (c) 2015 ccheng. All rights reserved.
//

import Foundation

public struct CmdUtil {
    
    public static func runAdbCb(args:[String], instant: ((result:String) -> Void)?) -> String {
        var task = NSTask()
        var adbPath = NSBundle.mainBundle().pathForResource("adb", ofType: "");
        task.launchPath = adbPath!;
        task.arguments = args;
        
        var pip = NSPipe()
        task.standardOutput = pip
        task.launch();
        
        let data = pip.fileHandleForReading.readDataToEndOfFile();
        let output:String = NSString(data: data, encoding: NSUTF8StringEncoding) as String!
        if let i = instant {
            dispatch_async(dispatch_get_main_queue(), {
                i(result:output)
            })
        }
        
        return output;
    }
    
    public static func runAdb(args:[String]) -> String {
        return runAdbCb(args, instant: nil)
    }

    
    public static func runAdbInBackground(args: [String], callback: (result:String) -> Void) {
        var taskQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)
        dispatch_async(taskQueue, {
            var result = self.runAdbCb(args, instant: callback)
        })
    }
    
    public static func getDevices() -> [Device]? {
        var output = runAdb(["devices"])
        var devices = parseDevices(output)
        return devices;
    }
    
    public static func getInstallCmd(device:Device, path:String)-> String {
        return "-s \(device.id) install -r \(path)";
    }
    
    public static func parseDevices(output: String) -> [Device]? {
        var ds = [Device]();
        for (index, line) in enumerate(output.componentsSeparatedByString("\n")) {
            if index > 0 && !line.isEmpty {
                ds.append(Device(device: line.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString: "\t "))[0]))
            }
        }
        return ds;
    }
    
    public static func installApk(device:Device, apkPath: String, updateConsole:(msg: String)-> Void) -> Bool {
        runAdbInBackground(getInstallCmd(device, path: apkPath).componentsSeparatedByString(" "), callback: {(result) -> Void in
                updateConsole(msg: result)
        });
        return true;
    }

}