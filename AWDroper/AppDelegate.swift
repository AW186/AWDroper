//
//  AppDelegate.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    static var window: NSWindow = NSWindow()
    lazy var window: NSWindow = {
        let window = NSWindow(contentRect: CGRect(x: 0, y: 0, width: 960, height: 540),
                         styleMask: [.titled,
                                     .resizable,
                                     .miniaturizable,
                                     .closable],
                         backing: .buffered,
                         defer: false)
        window.minSize = CGSize(width: 960, height: 540)
        window.center()
        return window
    }()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window.makeKeyAndOrderFront(nil)
        NSApplication.shared.mainWindow?.title = "AWDroper"
        let contentViewController = ViewController()
        window.contentViewController = contentViewController
        AppDelegate.window = self.window
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

