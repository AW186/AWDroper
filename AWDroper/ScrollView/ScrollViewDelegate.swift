//
//  ScrollViewDelegate.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 3/6/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

protocol ScrollViewDelegate: class {
    func scrollViewDidScroll(currentOffsetX: CGFloat, currentOffsetY: CGFloat)
}
