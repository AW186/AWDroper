//
//  NSViewExtension.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/24/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

extension NSView {
    var referenceOrigin: CGPoint {
        return self.superview == nil ? self.frame.origin : (self.superview?.referenceOrigin.plus(point: self.frame.origin))!
    }
    var boundCenter: CGPoint {
        return self.bounds.size.getCenter()
    }
    var center: CGPoint {
        get {
            return self.frame.origin.plus(point: boundCenter)
        }
        set {
            self.frame.origin = newValue.minus(point: boundCenter)
        }
    }
    func addCorner() {
        self.wantsLayer = true
        let cornerLength = (self.frame.width < self.frame.height ? self.frame.width : self.frame.height)/8
        let path = CGMutablePath()
        path.addRoundedRect(in: self.bounds, cornerWidth: cornerLength, cornerHeight: cornerLength)
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path
        self.layer?.mask = cornerLayer
    }
    func addTwoTopCorner() {
        self.wantsLayer = true
        let cornerLength = (self.frame.width < self.frame.height ? self.frame.width : self.frame.height)/8
        let path = CGMutablePath()
        path.addRoundedRect(in: self.bounds, cornerWidth: cornerLength, cornerHeight: cornerLength)
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path
        self.layer?.mask = cornerLayer
    }
    func addTwoTopCorner(by length: CGFloat) {
        self.wantsLayer = true
        let cornerLength = length
        let path = CGMutablePath()
        path.addRoundedRect(in: self.bounds, cornerWidth: cornerLength, cornerHeight: cornerLength)
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path
        self.layer?.mask = cornerLayer
    }
    func roundTwoSides() {
        self.wantsLayer = true
        let cornerLength = (self.frame.width < self.frame.height ? self.frame.width : self.frame.height)/2
        let cornerLayer = CAShapeLayer()
        let path = CGMutablePath()
        path.addRoundedRect(in: self.bounds, cornerWidth: cornerLength, cornerHeight: cornerLength)
        cornerLayer.path = path
        self.layer?.mask = cornerLayer
    }
    func makeCircle() {
        self.wantsLayer = true
        let cornerLength = (self.frame.width > self.frame.height ? self.frame.width : self.frame.height)/2
        let path = CGMutablePath()
        path.addRoundedRect(in: self.bounds, cornerWidth: cornerLength, cornerHeight: cornerLength)
        let cornerLayer = CAShapeLayer()
        cornerLayer.frame = bounds
        cornerLayer.path = path
        self.layer?.mask = cornerLayer
    }
}
