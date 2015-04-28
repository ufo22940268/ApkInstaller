//
//  testTests.swift
//  testTests
//
//  Created by ccheng on 4/28/15.
//  Copyright (c) 2015 ccheng. All rights reserved.
//

import Cocoa
import XCTest
import ApkInstaller

class testTests: XCTestCase {
    
    let output_has_devices = "List of devices attached\n" + "192.168.56.101:5555\t device";
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeviceClass() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass");
        var a = Device(device: "a");
        var b = Device(device: "a");
        XCTAssertEqual(a.id, b.id);
        XCTAssertEqual("a", "a");
    }
    
    func testParseCmd() {
        var devices = CmdUtil.parseDevices(output_has_devices);
        XCTAssert(devices?[0].id == "192.168.56.101:5555");
    }
    
    func testGetDevices() {
        var devices = CmdUtil.getDevices()
        XCTAssert(devices?.count === 1)
    }
    
    func testInstallCmd() {
        var device = Device(device: "asdf");
        XCTAssert(CmdUtil.getInstallCmd(device, path: "a.apk") == "-s asdf install a.apk");
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
