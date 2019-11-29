//
//  CGPointExtension.swift
//  SnapTest
//
//  Created by 王子豪 on 2018/6/28.
//  Copyright © 2018年 王子豪. All rights reserved.
//

import Foundation
import Cocoa

typealias Points = [CGPoint]
typealias Vector = CGPoint
let kPI = CGFloat(Double.pi)

extension CGPoint {
    init(size: CGFloat) {
        self.init(x: size, y: size)
    }
    init(radius: CGFloat, angle: CGFloat) {
        self.init()
        self.x = radius*CGFloat(cos(Double(angle)))
        self.y = radius*CGFloat(sin(Double(angle)))
    }
    func toArc() -> CGFloat {
        return x > 0 ?
            CGFloat(asin(Double(self.y/self.getLength()))) :
            CGFloat(Double.pi)-CGFloat(asin(Double(self.y/self.getLength())))
    }
    func isIn(rect: CGRect) -> Bool {
        var result = self.x > rect.minX
        result = result && self.x < rect.maxX
        result = result && self.y > rect.minY
        result = result && self.y < rect.maxY
        return result
    }
    func minus(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x-point.x, y: self.y-point.y)
    }
    func plus(point: CGPoint) -> CGPoint {
        return CGPoint(x: self.x+point.x, y: self.y+point.y)
    }
    func getUnitVectorByX() -> CGPoint {
        if self.x == 0 && self.y == 0 {
            return self
        }
        if self.x == 0 {
            print("error: dividor equals zero")
            return self
        }
        return CGPoint(x: 1, y: self.y/self.x)
    }
    func getUnitVectorByY() -> CGPoint {
        if self.x == 0 && self.y == 0 {
            return self
        }
        if self.y == 0 {
            print("error: dividor equals zero")
            return self
        }
        return CGPoint(x: self.x/self.y, y: 1)
    }
    func getUnitVectorByLength() -> CGPoint {
        let ratio = 1/self.getLength()
        return CGPoint(x: self.x*ratio, y: self.y*ratio)
    }
    func multipuly(by num: CGFloat) -> CGPoint {
        return CGPoint(x: self.x*num, y: self.y*num)
    }
    func divide(by num: CGFloat) -> CGPoint {
        return CGPoint(x: self.x/num, y: self.y/num)
    }
    func getLength() -> CGFloat {
        return CGFloat(sqrt(Double(self.x*self.x+self.y*self.y)))
    }
    func toSize() -> CGSize {
        return CGSize(width: self.x, height: self.y)
    }
    func horizantalShift(_ val: CGFloat) -> CGPoint {
        var point = self
        point.x += val
        return point
    }
    func verticalShift(_ val: CGFloat) -> CGPoint {
        var point = self
        point.y += val
        return point
    }
    static func getUnitVector(by angle: CGFloat) -> Vector {
        let angleInLoop: Double = Double(Int(angle)%360)+Double(angle)-Double(Int(angle))
        switch angleInLoop {
        case 0:
            return Vector(x: 1, y: 0)
        case 180:
            return Vector(x: -1, y: 0)
        case 360:
            return Vector(x: 1, y: 0)
        case 90:
            return Vector(x: 0, y: 1)
        case 270:
            return Vector(x: 0, y: -1)
        default:
            return Vector(x: cos(angleInLoop*Double.pi/180), y: sin(angleInLoop*Double.pi/180))
        }
    }
}
