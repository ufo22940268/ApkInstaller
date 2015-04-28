//
//  CmdUtil.swift
//  test
//
//  Created by ccheng on 4/28/15.
//  Copyright (c) 2015 ccheng. All rights reserved.
//

import Foundation

public struct CmdUtil {
    
    
    
    public static func getDevices() -> [Device] {
        var devices = [Device]()
        return devices;
    }
    
    public static func getInstallCmd(device:Device, path:String)-> String {
        return "-s \(device.id) install \(path)";
    }
    
    public static func parseDevices(output: String) -> [Device]? {
        var ds = [Device]();
        for (index, line) in enumerate(output.componentsSeparatedByString("\n")) {
            if index > 0 {
                ds.append(Device(device: line.componentsSeparatedByString(" ")[0]))
            }
        }
        return ds;
    }
    

}