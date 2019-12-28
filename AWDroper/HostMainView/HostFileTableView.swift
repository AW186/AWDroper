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
    override func rightMouseUp(with event: NSEvent) {
        let menu = NSMenu.init(title: "options")
        menu.addItem(NSMenuItem.init(title: "create new folder", action: #selector(createNewDirectory), keyEquivalent: ""))
        NSMenu.popUpContextMenu(menu, with: event, for: self)
    }
    @objc func createNewDirectory() {
        let url = data.getAbsPath()+"/new_folder"
        print(url)
        var index = 1
        while(FileManager.default.fileExists(atPath: url+"\(index)")) {
            index += 1
        }
        do {
            try FileManager.default
                .createDirectory(atPath: url+"\(index)",
                                 withIntermediateDirectories: true,
                                 attributes: nil)
            data.appendData("new_folder"+"\(index)", Int8(DT_DIR))
            reload()
        } catch {
            print(error.localizedDescription)
        }
    }
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
    func refresh() {
        
    }
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
    func rename(data: OCFileTreeNode, name: String) {
        guard data.getName() != name else {
            return
        }
        let previousName = data.getName()
        guard let oldPath = data.getAbsPath() else { return }
        data.rename(name);
        guard let url = data.getAbsPath() else { return }
        guard !FileManager.default.fileExists(atPath: url) else {
            _ = alert(question: "File already exists", text: "You can change the file name to another", btns: ["confirm"])
            data.rename(previousName)
            return
        }
        do {
            try FileManager.default
                .moveItem(atPath: oldPath, toPath: url)
        } catch {
            print(error.localizedDescription)
        }
        data.rename(name)
    }
    func delete(data: OCFileTreeNode) {
        do {
            try FileManager.default.removeItem(atPath: data.getAbsPath())
            data.remove()
            reload()
        } catch {
            print(error.localizedDescription)
        }
    }
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











