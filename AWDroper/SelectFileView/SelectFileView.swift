//
//  SelectFileView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 11/29/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class SelectFileView: NSView {
    weak var delegate: SelectFileViewDelegate?
    let label: NSTextField = NSTextField()
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setupSelf()
        setupLabel()
    }
    override func layout() {
        super.layout()
        layoutLabel()
    }
}
extension SelectFileView {
    func setupLabel() {
        label.removeFromSuperview()
        label.backgroundColor = NSColor.clear
        label.stringValue = "Add File"
        label.textColor = NSColor.blue
        label.font = NSFont.systemFont(ofSize: 20)
        label.isEditable = false
        label.isSelectable = false
        label.isBordered = false
        self.addSubview(label)
    }
    func layoutLabel() {
        label.sizeToFit()
        label.center = self.boundCenter
    }
    func setupSelf() {
        let gesture = NSClickGestureRecognizer.init(target: self, action: #selector(modalChooseFile))
        self.wantsLayer = true
        self.addGestureRecognizer(gesture)
        self.shadow = NSShadow()
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.layer?.shadowColor = NSColor.black.cgColor
        self.layer?.shadowRadius = 10
        self.layer?.shadowOpacity = 0.2
    }
    @objc func modalChooseFile() {
        let panel = NSOpenPanel.init()
        panel.canChooseDirectories = true
        panel.canChooseFiles = true
        panel.canCreateDirectories = true
        panel.runModal()
        if let url = panel.url {
            delegate?.fileDidOpened(url: url)
        }
    }
}











