//
//  HorizentalScrollView.swift
//  CalenderPlan
//
//10/20/18.
//
//

import Foundation
import Cocoa

class ScrollView: NSView {
    weak var scrollDelegate: ScrollViewDelegate?
    var contentView: NSView = NSView()
    var enableVerticleScrolling = false
    var enableHorizentalScrolling = false
    var offset: CGPoint {
        get {
            return CGPoint.zero.minus(point: contentView.frame.origin)
        }
        set {
            let val = CGPoint.init(x: -newValue.x,
                                   y: -newValue.y)
            setOffsetX(to: val.x)
            setOffsetY(to: val.y)
            scrollDelegate?.scrollViewDidScroll(currentOffsetX: offset.x, currentOffsetY: offset.y)
        }
    }
    func setOffsetX(to val: CGFloat) {
        guard self.contentView.frame.width > self.bounds.width else {
            return
        }
        contentView.frame.origin.x = val
        if val < -(contentView.bounds.width-self.bounds.width) {
            contentView.frame.origin.x = contentView.bounds.width-self.bounds.width
        }
        if val > 0 {
            contentView.frame.origin.x = 0
        }
    }
    func setOffsetY(to val: CGFloat) {
        guard self.contentView.frame.height > self.bounds.height else {
            contentView.frame.origin.y = self.frame.height-contentView.frame.height
            return
        }
        contentView.frame.origin.y = val
        if val < -(contentView.frame.height-self.bounds.height) {
            contentView.frame.origin.y = self.bounds.height-contentView.frame.height
        }
        if val > 0 {
            contentView.frame.origin.y = 0
        }
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        contentView.removeFromSuperview()
        contentView.layer?.masksToBounds = false
        self.addSubview(contentView)
    }
    override func scrollWheel(with event: NSEvent) {
        self.offset.y += event.scrollingDeltaY
    }
}
