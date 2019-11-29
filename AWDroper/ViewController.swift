//
//  ViewController.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var homeView = HomeView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeView()
        self.view.wantsLayer = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        homeView.frame = self.view.bounds
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    override func loadView() {
        guard let windowRect = NSApplication.shared.mainWindow?.frame else { return }
        view = NSView(frame: windowRect)
    }
    private func setupHomeView() {
        homeView.removeFromSuperview()
        homeView = HomeView(frame: self.view.bounds)
        homeView.recallBlk = { [unowned self] (arg) in
            let vc = LoginViewController.init()
            vc.hostOrGuest = arg
            vc.dismissSelf = { [self] in
                AppDelegate.window.contentViewController = self
//                self.dismissViewController(vc)
            }
            vc.login = { [unowned self] (status) in
                self.dismissViewController(vc)
            }
            AppDelegate.window.contentViewController = vc
//            self.presentViewControllerAsSheet(vc)
        }
        self.view.addSubview(homeView)
    }
}


