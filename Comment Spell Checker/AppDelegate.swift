//
//  AppDelegate.swift
//  Comment Spell Checker
//
//  Created by Velislava Yanchina on 24/11/18.
//  Copyright © 2018 Velislava Yanchina. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
        return true
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

extension AppDelegate {

    @IBAction private func helpMenuTwitterItemSelected(sender: AnyObject) {
        ExternalLinks.openTwitterProfile()
    }
    
    @IBAction private func helpMenuGitHubItemSelected(sender: AnyObject) {
        ExternalLinks.openGitHubPage()
    }
}

