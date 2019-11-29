//
//  HeaderView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/24/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

//Properties
class HeaderView: NSView {
    private var titleLabel: NSTextField = NSTextField()
    private var backButton: AWLabelButton = AWLabelButton(text: "Back")
    public var title: String = "" {
        didSet {
            setupTitle()
            layoutTitle()
        }
    }
    public var height: CGFloat = 75 {
        didSet {
            self.frame.size.height = self.height
        }
    }
    public var recallBlk: () -> Void = {    }
}
//Overrides
extension HeaderView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setupSelf()
        setupTitle()
        setupBackBtn()
    }
    override func layout() {
        super.layout()
        layoutTitle()
        layoutBackBtn()
    }
}
//Public funcs
extension HeaderView {
    public func layoutInBounds(_ rect: CGRect) {
        self.frame.size.width = rect.width
        self.frame.origin.x = 0
        self.frame.origin.y = rect.height-self.height
        self.frame.size.height = self.height
    }
}
//Private funcs
extension HeaderView {
    private func setupSelf() {
        self.wantsLayer = true
        self.shadow = NSShadow()
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.layer?.shadowColor = NSColor.black.cgColor
        self.layer?.shadowRadius = 10
        self.layer?.shadowOpacity = 0.2
    }
    private func setupTitle() {
        titleLabel.removeFromSuperview()
        titleLabel.stringValue = title
        titleLabel.backgroundColor = NSColor.clear
        titleLabel.isEditable = false
        titleLabel.isSelectable = false
        titleLabel.isBordered = false
        titleLabel.textColor = NSColor.darkGray
        titleLabel.font = NSFont.systemFont(ofSize: 36)
        titleLabel.alignment = .center
        titleLabel.sizeToFit()
        
        self.addSubview(titleLabel)
    }
    private func layoutTitle() {
        titleLabel.sizeToFit()
//        titleLabel.frame.size.width = 150
        titleLabel.center = self.boundCenter
    }
    private func setupBackBtn() {
        backButton.removeFromSuperview()
        backButton.sizeToFit()
//        backButton.frame.size.width = 100
        backButton.addReaction { [unowned self] in
            self.recallBlk()
        }
        self.addSubview(backButton)
    }
    private func layoutBackBtn() {
        backButton.sizeToFit()
        backButton.center = self.boundCenter
        backButton.frame.origin.x = 20
    }
}



