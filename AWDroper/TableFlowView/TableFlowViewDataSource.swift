//
//  TableViewDataSource.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 11/8/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

enum Alignment {
    case center
}
protocol TableFlowViewDataSource: class {
    func numberOfItems() -> Int
    func itemFor(index: Int) -> TableFlowCellView
    func alignment() -> Alignment
    func widthBetween() -> CGFloat
    func heightBetween() -> CGFloat
    func widthFormEdges() -> CGFloat
    func heightFormEdges() -> CGFloat
    func sizeOfCell() -> CGSize
}
