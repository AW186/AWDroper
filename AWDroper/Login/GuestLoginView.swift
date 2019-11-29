//
//  GuestLoginView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class GuestLoginView: LoginView {
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.title = "Guest"
        return view
    }()
    private let ipTextField: NSTextField = NSTextField()
    private let portTextField: NSTextField = NSTextField()
    private let passord: NSTextField = NSTextField()
    private var confirmBtn: NSButton = NSButton()
}

extension GuestLoginView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setupIPLabel()
        setupPassord()
        setupHeaderView()
        setupPortTextField()
        setupConfirmBtn()
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
    }
    override func layout() {
        super.layout()
        layoutIPLabel()
        layoutPortTextField()
        layoutPassord()
        layoutHeaderView()
        layoutConfirmBtn()
    }
}

extension GuestLoginView {
    private func setupPortTextField() {
        portTextField.removeFromSuperview()
        portTextField.removeFromSuperview()
        portTextField.placeholderString = "The server port is: "
        portTextField.isEditable = true
        portTextField.isSelectable = true
        portTextField.isBordered = true
        portTextField.backgroundColor = NSColor.clear
        portTextField.textColor = NSColor.darkGray
        portTextField.font = NSFont.systemFont(ofSize: 28)
        self.addSubview(portTextField)
    }
    private func layoutPortTextField() {
        portTextField.frame.size = ipTextField.frame.size
        portTextField.center = ipTextField.center
        portTextField.frame.leftTopCorner.y = ipTextField.frame.origin.y-20
    }
    private func setupConfirmBtn() {
        confirmBtn.removeFromSuperview()
        defer {
            self.addSubview(confirmBtn)
        }
        confirmBtn = NSButton.init(title: "confirm", target: self, action: #selector(confirm))
        confirmBtn.font = NSFont.systemFont(ofSize: 24)
    }
    @objc private func confirm() {
        guard let port: CShort = CShort(portTextField.stringValue) else {
            _ = alert(question: "The port must be an integer with range from 1000 to 65536", text: "", btns: ["cancel"])
            return
        }
        delegate?.login(status: .guestLogin(ipAddress: ipTextField.stringValue, port: port, passord: passord.stringValue))
    }

    private func layoutConfirmBtn() {
        confirmBtn.sizeToFit()
        confirmBtn.frame.size.height += 10
        confirmBtn.center = self.boundCenter
        confirmBtn.center.y -= 150
    }
    private func setupHeaderView() {
        headerView.removeFromSuperview()
        headerView.recallBlk = { [unowned self] in
            self.delegate?.back()
        }
        self.addSubview(headerView)
    }
    private func layoutHeaderView() {
        headerView.layoutInBounds(self.bounds)
    }
    private func setupIPLabel() {
        ipTextField.removeFromSuperview()
        ipTextField.removeFromSuperview()
        ipTextField.placeholderString = "The server IP address is: "
        ipTextField.isEditable = true
        ipTextField.isSelectable = true
        ipTextField.isBordered = true
        ipTextField.backgroundColor = NSColor.clear
        ipTextField.textColor = NSColor.darkGray
        ipTextField.font = NSFont.systemFont(ofSize: 28)
        self.addSubview(ipTextField)
    }
    private func layoutIPLabel() {
        ipTextField.sizeToFit()
        ipTextField.center = self.boundCenter
        ipTextField.center.y += 40
        print(ipTextField.frame)
    }
    private func setupPassord() {
        passord.removeFromSuperview()
        passord.isEditable = true
        passord.isSelectable = true
        passord.placeholderString = "passord: "
        passord.font = NSFont.systemFont(ofSize: 28)
        passord.isBordered = true
        passord.textColor = NSColor.black
        passord.stringValue = ""
        self.addSubview(passord)
    }
    private func layoutPassord() {
        passord.sizeToFit()
        passord.frame.size.width = ipTextField.frame.width
        passord.center = self.boundCenter
        passord.frame.leftTopCorner.y = portTextField.frame.origin.y-20
    }
}

