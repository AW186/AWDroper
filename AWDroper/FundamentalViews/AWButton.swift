//
//  AWButton.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class AWButton: NSView {
    private var reactBlk: () -> () = {}
    private var clickGesture: NSClickGestureRecognizer = NSClickGestureRecognizer()
    func addReaction(blk: @escaping () -> ()) {
        self.removeGestureRecognizer(clickGesture)
        reactBlk = {
            blk()
        }
        let gesture = NSClickGestureRecognizer.init(target: self, action: #selector(reaction))
        self.addGestureRecognizer(gesture)
    }
    @objc private func reaction() {
        reactBlk()
    }
}
