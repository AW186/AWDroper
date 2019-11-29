//
//  TableFlowView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 11/8/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class TableFlowView: NSView {
    weak var delegate: TableFlowViewDelegate?
    weak var dataSource: TableFlowViewDataSource?
    private var contentView: NSView = NSView()
    private var scrollView: ScrollView = ScrollView()
    private var cells: [TableFlowCellView] = [TableFlowCellView]()
}
extension TableFlowView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.clear.cgColor
        setupItems()
    }
    override func layout() {
        super.layout()
        layoutItems()
    }
}
extension TableFlowView {
    func removeAllTint() {
        cells.forEach { (cell) in
            cell.setTint(tint: false)
        }
    }
    func reload() {
        setupItems()
        layoutItems()
    }
    func insertNew(item: TableFlowCellView, at index: Int) {
        cells.append(item)
        self.addSubview(item)
        layoutItems()
    }
    func removeItem(at index: Int) {
        cells[index].removeFromSuperview()
        cells.remove(at: index)
        layoutItems()
    }
    func removeItem(item: NSView) {
        item.removeFromSuperview()
        for index in 0..<cells.count {
            if (item == cells[index]) {
                cells.remove(at: index)
            }
        }
        layoutItems()
    }
}
extension TableFlowView {
    private func setupItems() {
        scrollView.removeFromSuperview()
        contentView.removeFromSuperview()
        cells.forEach { (cell) in
            cell.removeFromSuperview()
        }
        cells.removeAll()
        guard let dataSource = self.dataSource else {
            return
        }
        let numberOfItems = dataSource.numberOfItems()
        for index in 0..<numberOfItems {
            cells.append(dataSource.itemFor(index: index))
            self.contentView.addSubview(cells[index])
        }
        contentView.wantsLayer = true
        scrollView.contentView = self.contentView
        self.addSubview(scrollView)
    }
    private func layoutItems() {
        self.scrollView.frame = self.bounds
        guard let dataSource = self.dataSource else { return }
        let numberOfCells = dataSource.numberOfItems()
        var widthBetween = dataSource.widthBetween()
        let heightBetween = dataSource.heightBetween()
        let widthFromEdge = dataSource.widthFormEdges()
        let heightFromEdge = dataSource.heightFormEdges()
        let size = dataSource.sizeOfCell()
        let cellsInRow: Int = Int((self.frame.width-2*widthFromEdge+widthBetween)/(widthBetween+size.width))
        guard cellsInRow > 0 else {
            return
        }
        let totalHeight = 2*heightFromEdge +
            CGFloat(ceil(Double(numberOfCells)/Double(cellsInRow)))*(size.height+heightBetween) - heightBetween
        var posY = totalHeight-size.height-heightFromEdge
        var posX = widthFromEdge
        print("height: ",totalHeight)
        self.contentView.frame = CGRect.init(x: 0,
                                             y: 0,
                                             width: self.frame.width,
                                             height: totalHeight)
        if (cellsInRow > 1) {
            widthBetween = (self.frame.width-2*widthFromEdge-CGFloat(cellsInRow)*size.width)/CGFloat(cellsInRow-1)
            cells.forEach { (cell) in
                cell.frame.origin = CGPoint(x: posX, y: posY)
                cell.frame.size = dataSource.sizeOfCell()
                cell.wantsLayer = true
                posY -= (posX+size.width+widthBetween+widthFromEdge) > self.frame.width ?
                    size.height+heightBetween : 0
                posX = (posX+size.width+widthBetween+widthFromEdge) > self.frame.width ?
                    widthFromEdge : posX+size.width+widthBetween
            }
        } else {
            cells.forEach { (cell) in
                cell.center.x = self.boundCenter.x
                cell.frame.origin.y = posY
                posY += heightBetween+size.height
            }
        }
        scrollView.setOffsetY(to: -self.contentView.frame.height)
    }
}
