//
//  TableFlowCellView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 11/18/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class TableFlowCellView: NSView {
    
    private var tint = false
    var isTint: Bool {
        get {
            return self.tint
        }
    }
    func refreshTint() {
        setTint(tint: !self.tint)
    }
    func setTint(tint: Bool) {
        self.tint = tint
        self.layer?.shadowOpacity = self.tint ? 0.8 : 0.2
        self.layer?.shadowColor = self.tint ? NSColor.blue.cgColor : NSColor.black.cgColor
    }
}
