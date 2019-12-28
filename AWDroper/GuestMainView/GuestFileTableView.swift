//
//  GuestFileTableView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 12/15/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class GuestFileTableView: NSView {
    private var data: OCFileTreeNode
    init(data: OCFileTreeNode) {
        self.data = data
        super.init(frame: CGRect.zero)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
