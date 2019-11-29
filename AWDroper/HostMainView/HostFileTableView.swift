//
//  HostFileTableView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/24/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa


class HostFileTableView: NSView {
    private var hostFileViews: TableFlowView = TableFlowView()
    private let maskView: NSView = NSView()
    var data: OCFileTreeNode {
        didSet {
            reload()
        }
    }
    var enterFolderBlk: (OCFileTreeNode) -> Void = { _ in }
    init(data: OCFileTreeNode) {
        self.data = data
        super.init(frame: CGRect.zero)
        self.registerForDraggedTypes([NSPasteboard.PasteboardType.URL, NSPasteboard.PasteboardType.fileURL])
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension HostFileTableView {
    override func draggingEnded(_ sender: NSDraggingInfo) {
        maskView.removeFromSuperview()
    }
    override func draggingExited(_ sender: NSDraggingInfo?) {
        maskView.removeFromSuperview()
    }
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        self.addSubview(maskView)
        return .copy
    }
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard let pasteboard = sender.draggingPasteboard()
            .propertyList(forType: NSPasteboard
                .PasteboardType(rawValue: "NSFilenamesPboardType")) as? NSArray,
              let path = pasteboard[0] as? String
            else { return false } //Copied from stackoverflow: https://stackoverflow.com/questions/31657523/os-x-swift-get-file-path-using-drag-and-drop
        if (link(data.getPath(), path) != 0) {
            perror("link: ")
        }
        Swift.print("FilePath: \(path)")
        return true
    }
    
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        self.wantsLayer = true
        self.layer?.backgroundColor = NSColor.white.cgColor
        setupFileViews()
        setupMaskView()
    }
    override func layout() {
        super.layout()
        print(self.bounds)
        hostFileViews.frame = self.bounds
        maskView.frame = self.bounds
    }
}

extension HostFileTableView {
    private func setupMaskView() {
        maskView.wantsLayer = true
        maskView.alphaValue = 0.3
        maskView.layer?.backgroundColor = NSColor.lightGray.cgColor
    }
    private func setupFileViews() {
        hostFileViews.removeFromSuperview()
        hostFileViews = TableFlowView.init(frame: self.bounds)
        hostFileViews.dataSource = self
        hostFileViews.delegate = self
        self.addSubview(hostFileViews)
    }
}

extension HostFileTableView: TableFlowViewDelegate {
    func itemWillDelelte(index: Int, view: NSView) {
        
    }
    func itemDidSelected(index: Int, view: NSView) {
        
    }
}

extension HostFileTableView: FileViewDelegate {
    func enterFolder(data: OCFileTreeNode) {
        self.data = data
        self.enterFolderBlk(data)
    }
    func tintWillSet() {
        self.hostFileViews.removeAllTint()
    }
}

extension HostFileTableView: TableFlowViewDataSource {
    func reload() {
        self.hostFileViews.reload()
    }
    func numberOfItems() -> Int {
        return data.getChildren().count
    }
    func itemFor(index: Int) -> TableFlowCellView {
        let value = data.getChildren()[index]
        let view = HostFileView(data: value as! OCFileTreeNode)
        view.delegate = self
        return view
    }
    func alignment() -> Alignment {
        return .center
    }
    func widthBetween() -> CGFloat {
        return 30
    }
    func heightBetween() -> CGFloat {
        return 30
    }
    func widthFormEdges() -> CGFloat {
        return 70
    }
    func heightFormEdges() -> CGFloat {
        return 30
    }
    func sizeOfCell() -> CGSize {
        return CGSize(width: 300, height: 120)
    }
}











