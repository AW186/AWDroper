//
//  GuestView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 12/15/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class GuestView: NSView {
    private var contentView: GuestFileTableView
    private var data: OCFileTreeNode
    private var guestFileViews: TableFlowView = TableFlowView()
    private var bottomView: BottomView
    private var headerView: HeaderView = HeaderView()
    init(data: OCFileTreeNode) {
        self.data = data
        self.bottomView = BottomView(data: data)
        self.contentView = GuestFileTableView(data: data)
        super.init(frame: CGRect.zero)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


