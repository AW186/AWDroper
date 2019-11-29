//
//  HomeView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

//Properties
class HomeView: NSView {
    private let guestButton: AWImageButton = AWImageButton(#imageLiteral(resourceName: "GuestBtn"));
    private let hostButton: AWImageButton = AWImageButton(#imageLiteral(resourceName: "HostBtn"));
    private let title: NSTextView = NSTextView()
    public var recallBlk: (HostOrGuest) -> Void = { _ in }
}
//Overrides
extension HomeView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
        setupHostButton()
        setupGuestButton()
        setupTitle()
    }
    override func layout() {
        super.layout()
        let adjustRect = self.bounds.adjustRect(by: SCREENRATIO)
        layoutGuestButton(in: adjustRect)
        layoutHostButton(in: adjustRect)
        layoutTitle(in: adjustRect)
    }
}
//Private functions
extension HomeView {
    private func setupTitle() {
        title.removeFromSuperview()
        title.isSelectable = false
        title.isEditable = false
        title.backgroundColor = NSColor.clear
        title.string = "Choose your identity..."
        title.font = NSFont.systemFont(ofSize: 28)
        title.textColor = NSColor.darkGray
        title.alignment = .center
        self.addSubview(title)
    }
    private func layoutTitle(in rect: CGRect) {
        title.frame.size.width = 500
        title.sizeToFit()
        title.frame.bottomMid = self.bounds.size.getCenter()
        title.frame.bottomMid.y += guestButton.frame.height*2/3
        print("title.frame: \(title.frame)")
    }
    private func setupGuestButton() {
        guestButton.removeFromSuperview()
        guestButton.addReaction { [unowned self] in
            self.recallBlk(.guest)
        }
        self.addSubview(guestButton)
    }
    private func layoutGuestButton(in rect: CGRect) {
        guestButton.frame = CGRect(x: 1.0/7.0*rect.width,
                                   y: 1.0/7.0*rect.height,
                                   width: 2.0/7.0*rect.width,
                                   height: 2.0/3.0*rect.height)
        self.guestButton.frame.origin = self.guestButton.frame.origin.plus(point: rect.origin)
    }
    private func setupHostButton() {
        hostButton.removeFromSuperview()
        hostButton.addReaction { [unowned self] in
            self.recallBlk(.host)
        }
        self.addSubview(hostButton)
    }
    private func layoutHostButton(in rect: CGRect) {
        hostButton.frame = CGRect(x: 4.0/7.0*rect.width,
                                  y: 1.0/7.0*rect.height,
                                  width: 2.0/7.0*rect.width,
                                  height: 2.0/3.0*rect.height)
        self.hostButton.frame.origin = self.hostButton.frame.origin.plus(point: rect.origin)
    }
}
