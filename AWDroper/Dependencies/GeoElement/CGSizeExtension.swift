//
//  CGSizeExtension.swift
//
//  Created by 王子豪 on 2018/7/12.
//  Copyright © 2018年 王子豪. All rights reserved.
//

import Foundation
import Cocoa

extension CGSize {
    func toFrame() -> CGRect {
        return CGRect.init(origin: CGPoint.zero, size: self)
    }
    var leftTopCorner: CGPoint {
        return CGPoint(x: 0, y: self.height)
    }
    var rightTopCorner: CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }
    var leftBottomCorner: CGPoint {
        return CGPoint(x: 0, y: 0)
    }
    var rightBottomCorner: CGPoint {
        return CGPoint(x: self.width, y: 0)
    }
    var topMid: CGPoint {
        return CGPoint(x: self.width/2, y: self.width)
    }
    var rightMid: CGPoint {
        return CGPoint(x: self.width, y: self.height/2)
    }
    var leftMid: CGPoint {
        return CGPoint(x: 0, y: self.height/2)
    }
    var bottomMid: CGPoint {
        return CGPoint(x: self.width/2, y: 0)
    }
    init(length: CGFloat) {
        self.init(width: length, height: length)
    }
    func add(size: CGSize) -> CGSize {
        let width = self.width+size.width
        let height = self.height+size.height
        return CGSize(width: width, height: height)
    }
    func minus(size: CGSize) -> CGSize {
        let width = self.width-size.width
        let height = self.height-size.height
        return CGSize(width: width, height: height)
    }
    func scaled(by ratio: CGFloat) -> CGSize {
        return CGSize(width: self.width*ratio, height: self.height*ratio)
    }
    func getCenter() -> CGPoint {
        return CGPoint(x: self.width/2, y: self.height/2)
    }
    func toPoint() -> CGPoint {
        return CGPoint(x: self.width, y: self.height)
    }
}
