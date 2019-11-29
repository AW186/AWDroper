//
//  BottomView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/24/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class BottomView: NSView {
    weak var delegate: BottomViewDelegate?
    private let backButton: AWLabelButton = AWLabelButton(text: "")
    private let pathLabel: NSTextField = NSTextField()
    public var data: OCFileTreeNode {
        didSet {
            pathLabel.stringValue = data.getPath()
        }
    }
    init(data: OCFileTreeNode) {
        self.data = data
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public var height: CGFloat = 75 {
        didSet {
            self.frame.size.height = self.height
        }
    }
}

extension BottomView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setupSelf()
        setupPathLabel()
        setupBackButton()
    }
    override func layout() {
        super.layout()
        layoutBackButton()
        layoutPathLabel()
    }
}

extension BottomView {
    public func layoutInBounds(_ rect: CGRect) {
        self.frame.size.width = rect.width
        self.frame.origin.x = 0
        self.frame.origin.y = 0
        self.frame.size.height = self.height
    }
    private func setupSelf() {
        self.wantsLayer = true
        self.shadow = NSShadow()
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.layer?.shadowColor = NSColor.black.cgColor
        self.layer?.shadowRadius = 10
        self.layer?.shadowOpacity = 0.2
    }
    private func setupBackButton() {
        backButton.removeFromSuperview()
        backButton.text = "<-Back"
        backButton.addReaction { [unowned self] in
            self.delegate?.backToPreviousDirectory()
        }
        self.addSubview(backButton)
    }
    private func layoutBackButton() {
        backButton.sizeToFit()
        backButton.center.y = self.boundCenter.y
        backButton.frame.origin.x = 20
    }
    private func setupPathLabel() {
        pathLabel.removeFromSuperview()
        pathLabel.isEditable = false
        pathLabel.isSelectable = true
        pathLabel.stringValue = data.getPath()
        pathLabel.font = NSFont.systemFont(ofSize: 20)
        pathLabel.textColor = NSColor.darkGray
        self.addSubview(pathLabel)
    }
    private func layoutPathLabel() {
        pathLabel.sizeToFit()
        pathLabel.frame.size.width = self.frame.width*3/4
        pathLabel.center = self.boundCenter
        pathLabel.frame.origin.x = backButton.frame.rightTopCorner.x+25
    }
}




