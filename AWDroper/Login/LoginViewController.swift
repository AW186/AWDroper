//
//  LoginViewController.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class LoginViewController: NSViewController {
    var hostOrGuest: HostOrGuest = .host
    var dismissSelf: () -> Void = {}
    var login: (HostOrGuestLogin)->Void = { _ in }
    weak var delegate: LoginViewDelegate?
    private var loginView: LoginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch hostOrGuest {
        case .host:
            loginView = HostLoginView()
        case .guest:
            loginView = GuestLoginView()
        }
        loginView.wantsLayer = true
        loginView.delegate = self
//        loginView.layer?.backgroundColor = NSColor.red.cgColor
        self.view.addSubview(loginView)
    }
    
    override func viewDidLayout() {
        super.viewDidLayout()
        loginView.frame = self.view.bounds
    }
    override func loadView() {
        guard let windowRect = NSApplication.shared.mainWindow?.frame else { return }
        view = NSView(frame: windowRect)
    }
}

extension LoginViewController: LoginViewDelegate {
    func login(status: HostOrGuestLogin) {
        switch status {
        case .guestLogin(let ipAddress, let port, let passord):
            break
        case .hostLogin(let passord):
            let vc = HostViewController.init()
            vc.passord = passord
            vc.view.wantsLayer = false
            vc.view.layer?.backgroundColor = NSColor.black.cgColor
            vc.dismissSelf = { [unowned self] in
                AppDelegate.window.contentViewController = self
            }
            AppDelegate.window.contentViewController = vc
//            self.presentViewControllerAsSheet(vc)
            break
        }
    }
    func back() {
        dismissSelf()
    }
}
