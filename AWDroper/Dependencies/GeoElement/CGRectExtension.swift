//
//  CGRectExtension.swift
//
//  Created by 王子豪 on 2018/7/12.
//  Copyright © 2018年 王子豪. All rights reserved.
//

import Foundation
import Cocoa

extension CGRect {
    static func initFrom(size: CGSize) -> CGRect {
        return size.toFrame()
    }
    var heightUnit: CGFloat {
        return self.height/50
    }
    var widthUnit: CGFloat {
        return self.width/50
    }
    var smallSquare: CGRect {
        let length = self.width < self.height ? self.width : self.height
        return CGRect.init(origin: self.origin
            .plus(point: self.size.getCenter()
                .minus(point: CGPoint.init(size: length/2))),
                           size: CGSize.init(length: length))
    }
    var largeSquare: CGRect {
        let length = self.width > self.height ? self.width : self.height
        return CGRect.init(origin: self.origin, size: CGSize.init(length: length))
    }
    var rightTopCorner: CGPoint {
        get {
            return self.size.rightTopCorner.plus(point: self.origin)
        }
        set {
            self.origin = newValue.minus(point: self.size.rightTopCorner)
        }
    }
    var leftTopCorner: CGPoint {
        get {
            return self.size.leftTopCorner.plus(point: self.origin)
        }
        set {
            self.origin = newValue.minus(point: self.size.leftTopCorner)
        }
    }
    var rightBottomCorner: CGPoint {
        get {
            return self.size.rightBottomCorner.plus(point: self.origin)
        }
        set {
            self.origin = newValue.minus(point: self.size.rightBottomCorner)
        }
    }
    var leftBottomCorner: CGPoint {
        get {
            return self.size.leftBottomCorner.plus(point: self.origin)
        }
        set {
            self.origin = newValue.minus(point: self.size.leftBottomCorner)
        }
    }
    var topMid: CGPoint {
        get {
            return self.size.topMid.plus(point: self.origin)
        }
        set {
            self.origin = newValue.minus(point: self.size.topMid)
        }
    }
    var rightMid: CGPoint {
        get {
            return self.size.rightMid.plus(point: self.origin)
        }
        set {
            self.origin = newValue.minus(point: self.size.rightMid)
        }
    }
    var leftMid: CGPoint {
        get {
            return self.size.leftMid.plus(point: self.origin)
        }
        set {
            self.origin = newValue.minus(point: self.size.leftMid)
        }
    }
    var bottomMid: CGPoint {
        get {
            return self.size.bottomMid.plus(point: self.origin)
        }
        set {
            self.origin = newValue.minus(point: self.size.bottomMid)
        }
    }
    func growBig(byScale scale: CGFloat) -> CGRect {
        let increasedWidth = self.width*(scale-1)/2
        let increasedHeight = self.height*(scale-1)/2
        let origin = self.origin.minus(point: CGPoint(x: increasedWidth, y: increasedHeight))
        let size = self.size.add(size: CGSize(width: increasedWidth*2, height: increasedHeight*2))
        return CGRect(origin: origin, size: size)
    }
    func growBig(byRadius radius: CGFloat) -> CGRect {
        let origin = self.origin.minus(point: CGPoint(size: radius))
        let size = self.size.add(size: CGSize(width: radius*2, height: radius*2))
        return CGRect(origin: origin, size: size)
    }
}
