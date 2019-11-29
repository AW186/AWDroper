//
//  CGRect+Adjust.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

extension CGRect {
    func adjustRect(by ratio: CGFloat) -> CGRect {
        if (ratio > self.height/self.width) {
            var newRect = self
            newRect.size.width = self.height/ratio
            newRect.origin.x += (self.width-newRect.width)/2
            return newRect
        } else {
            var newRect = self
            newRect.size.height = self.width*ratio
            newRect.origin.y += (self.height-newRect.height)/2
            return newRect
        }
    }
}
