//
//  AWImageButton.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class AWImageButton: AWButton {
    private var image: NSImageView = NSImageView.init()
    init(_ imageFile: NSImage) {
        super.init(frame: NSRect())
        image = NSImageView(image: imageFile)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AWImageButton {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        self.addSubview(image)
        self.wantsLayer = true
        self.shadow = NSShadow()
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.layer?.shadowColor = NSColor.black.cgColor
        self.layer?.shadowRadius = 10
        self.layer?.shadowOpacity = 0.2
    }
    override func layout() {
        super.layout()
        layoutImageView()
    }
}

extension AWImageButton {
    func layoutImageView() {
        guard let image = self.image.image else {
            return
        }
        let adjustRect = self.bounds.adjustRect(by: image.size.height/image.size.width)
        self.image.frame = adjustRect
        self.image.frame.origin = self.image.frame.origin.plus(point: adjustRect.origin)
    }
}




