//
//  HostFileView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/24/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class HostFileView: FileView {
    private var permitionView: AWLabelButton = AWLabelButton(text: "readWrite")
    internal var permition: Permition = .readWrite {
        didSet {
            permitionView.text = self.text
        }
    }
    private var text: String {
        get {
            return permition == .readWrite ? readWrite : readOnly
        }
    }
    let readOnly = "READONLY"
    let readWrite = "READWRITE"
}
extension HostFileView {
    override func layout() {
        super.layout()
        layoutPermitionView()
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setupPermitionView()
    }
}
extension HostFileView {
    private func setupPermitionView() {
        permitionView.removeFromSuperview()
        permitionView = AWLabelButton.init(text: self.text)
        permitionView.addReaction { [unowned self] in
            self.setPermition()
        }
        self.addSubview(permitionView)
    }
    private func layoutPermitionView() {
        permitionView.sizeToFit()
        permitionView.center.x = super.titleLabel.center.x
        permitionView.frame.origin.y = 20
    }
    private func setPermition() {
        permition = permition == .readWrite ? .readOnly : .readWrite
        permitionView.text = permition == .readWrite ? readWrite : readOnly
        layoutPermitionView()
    }
}
