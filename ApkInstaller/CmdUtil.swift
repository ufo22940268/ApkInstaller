//
//  CmdUtil.swift
//  test
//
//  Created by ccheng on 4/28/15.
//  Copyright (c) 2015 ccheng. All rights reserved.
//

import Foundation

public struct CmdUtil {
    
    
    
    public static func getDevices() -> [Device]? {
        var adbPath = NSBundle.mainBundle().pathForResource("adb", ofType: "");
        var task = NSTask()
        task.launchPath = adbPath!
        task.arguments = ["devices"];
        
        var pip = NSPipe()
        task.standardOutput = pip
        task.launch();
        
        let data = pip.fileHandleForReading.readDataToEndOfFile();
        let output:String = NSString(data: data, encoding: NSUTF8StringEncoding) as String!
        var devices = parseDevices(output)
        return devices;
    }
    
    public static func getInstallCmd(device:Device, path:String)-> String {
        return "-s \(device.id) install \(path)";
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
    

}