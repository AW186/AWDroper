//
//  AWLabelButton.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/24/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class AWLabelButton: AWButton {
    private let label: NSTextField = NSTextField()
    var text: String {
        didSet {
            setupLabel()
            layoutLabel()
        }
    }
    init(text: String) {
        self.text = text
        super.init(frame: CGRect())
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AWLabelButton {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setupLabel()
    }
    override func layout() {
        super.layout()
        layoutLabel()
    }
}

extension AWLabelButton {
    private func setupLabel() {
        label.removeFromSuperview()
        label.backgroundColor = NSColor.clear
        label.textColor = NSColor.blue
        label.font = NSFont.systemFont(ofSize: 20)
        label.isEditable = false
        label.isSelectable = false
        label.isBordered = false
        label.attributedStringValue = NSAttributedString.init(string: text, attributes: [kCTUnderlineStyleAttributeName as NSAttributedStringKey: NSUnderlineStyle.styleSingle.rawValue])
        label.sizeToFit()
        self.addSubview(label)
    }
    private func layoutLabel() {
        label.sizeToFit()
        label.frame.origin = self.bounds.origin
    }
    func sizeToFit() {
        label.sizeToFit()
        self.frame.size = label.frame.size
    }
}
