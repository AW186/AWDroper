//
//  TableFlowViewDelegate.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 11/8/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

protocol TableFlowViewDelegate: class {
    func itemWillDelelte(index: Int, view: NSView)
    func itemDidSelected(index: Int, view: NSView)
}
