//
//  AnimatableView.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 1/12/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class AWAnimator: NSObject {
    static let defualt = AWAnimator()
    var awAnimations: [String: AWAnimation] = [:]
    func addNewAnimation(duration: TimeInterval, animationBlk: @escaping (CGFloat) -> Void, identifier: String, option: AnimationsRelationOptions) -> Bool {
        guard awAnimations[identifier] == nil else {
            return false
        }
        self.doOption(opt: option)
        awAnimations[identifier] = AWAnimation.init(duration: duration, actionBlk: animationBlk)
        return true
    }
    func addNewAnimation(duration: TimeInterval, animationBlk: @escaping (CGFloat) -> Void, identifier: String, completeBlk: (Bool) -> Void, option: AnimationsRelationOptions) -> Bool {
        guard awAnimations[identifier] == nil else {
            return false
        }
        self.doOption(opt: option)
        awAnimations[identifier] = AWAnimation.init(duration: duration, actionBlk: animationBlk)
        return true
    }
    func removeAnimation(with identifier: String) {
        guard let animation = awAnimations[identifier] else {
            return
        }
        animation.stopAnimate()
        awAnimations.removeValue(forKey: identifier)
    }
    func removeAllAnimations() {
        awAnimations.forEach { (_, anim) in
            anim.stopAnimate()
        }
        awAnimations.removeAll()
    }
    enum AnimationsRelationOptions {
        case deleteAnimation(String)
        case deleteAnimations([String])
        case deleteAll
        case none
    }
    private func doOption(opt: AnimationsRelationOptions) {
        switch opt {
        case .deleteAll:
            removeAllAnimations()
        case .deleteAnimation(let str):
            removeAnimation(with: str)
        case .deleteAnimations(let strs):
            strs.forEach { (str) in
                removeAnimation(with: str)
            }
        case .none:
            break
        }
    }
}
