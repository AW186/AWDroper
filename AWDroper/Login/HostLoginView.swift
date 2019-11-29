//
//  HostLoginView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class HostLoginView: LoginView {
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.title = "Host Login"
        return view
    }()
    private let ipLabel: NSTextField = NSTextField()
    private let passord: NSTextField = NSTextField()
    private var confirmBtn: NSButton = NSButton()
}

extension HostLoginView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setupIPLabel()
        setupPassord()
        setupHeaderView()
        setupConfirmBtn()
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
    }
    override func layout() {
        super.layout()
        layoutIPLabel()
        layoutPassord()
        layoutHeaderView()
        layoutConfirmBtn()
    }
}

extension HostLoginView {
    private func setupConfirmBtn() {
        confirmBtn.removeFromSuperview()
        defer {
            self.addSubview(confirmBtn)
        }
        confirmBtn = NSButton.init(title: "confirm", target: self, action: #selector(confirm))
        confirmBtn.font = NSFont.systemFont(ofSize: 24)
    }
    @objc private func confirm() {
        self.delegate?.login(status: .hostLogin(passord: passord.stringValue))
    }
    private func layoutConfirmBtn() {
        confirmBtn.sizeToFit()
        confirmBtn.frame.size.height += 10
        confirmBtn.center = self.boundCenter
        confirmBtn.center.y -= 100
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
        ipLabel.removeFromSuperview()
        var ipaddr: String = "xx.xx.xx.xx"
        do {
            try ipaddr = getIPAddress()
        } catch {
            let ipError = error as! GetIPError
            print(ipError.localizedDescription)
        }
        ipLabel.removeFromSuperview()
        ipLabel.stringValue = "Your IP address is: \(ipaddr)"
        ipLabel.isEditable = false
        ipLabel.isSelectable = false
        ipLabel.isBordered = false
        ipLabel.backgroundColor = NSColor.clear
        ipLabel.textColor = NSColor.darkGray
        ipLabel.font = NSFont.systemFont(ofSize: 28)
        self.addSubview(ipLabel)
    }
    private func layoutIPLabel() {
        ipLabel.sizeToFit()
        ipLabel.center = self.boundCenter
        ipLabel.center.y += 40
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
        passord.frame.size.width = ipLabel.frame.width
        passord.center = self.boundCenter
        passord.center.y -= 40
    }
}
