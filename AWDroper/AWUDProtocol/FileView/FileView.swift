//
//  FileView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 11/16/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class FileView: TableFlowCellView {
    enum Format {
        case file
        case folder
    }
    enum Permition {
        case readWrite
        case readOnly
    }
    var format: Format {
        get {
            return data.getType() == DT_DIR ? .folder : .file
        }
    }
    weak var delegate: FileViewDelegate?
    var recallBlk: (OCFileTreeNode) -> Void = { _ in }
    private var lastClick: TimeInterval = NSDate().timeIntervalSince1970
    let data: OCFileTreeNode
    internal var titleLabel: NSTextField = NSTextField()
    private lazy var iconView: NSImageView = {
        let view: NSImageView
        if data.getType() == DT_DIR {
            view = NSImageView(image: #imageLiteral(resourceName: "FolderIcon"))
        } else {
            view = NSImageView(image: #imageLiteral(resourceName: "FileIcon"))
        }
        return view
    }()
    init(data: OCFileTreeNode) {
        self.data = data
        super.init(frame: CGRect.zero)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension FileView {
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setupSelf()
        setupIconView()
        setupTitleLabel()
    }
    override func layout() {
        super.layout()
        layoutIconView()
        layoutTitleLabel()
    }
}
extension FileView {
    func resetTitle() {
        setupTitleLabel()
        layoutTitleLabel()
    }
    private func setupSelf() {
        self.wantsLayer = true
        self.shadow = NSShadow()
        self.layer?.backgroundColor = NSColor.white.cgColor
        self.layer?.shadowColor = NSColor.black.cgColor
        self.layer?.shadowRadius = 10
        self.layer?.shadowOpacity = 0.2
        let gesture = NSClickGestureRecognizer.init(target: self, action: #selector(clickEvent))
        self.addGestureRecognizer(gesture)
    }
    
    @objc private func clickEvent() {
        if !super.isTint {
            self.delegate?.tintWillSet()
        }
        refreshTint()
        guard format == .folder else {
            return
        }
        if (NSDate().timeIntervalSince1970-lastClick < 0.5) {
            self.delegate?.enterFolder(data: data)
        }
        lastClick = NSDate().timeIntervalSince1970
    }
    private func setupIconView() {
        iconView.removeFromSuperview()
        self.addSubview(iconView)
    }
    private func layoutIconView() {
        iconView.frame = CGRect.init(x: 10,
                                     y: 10,
                                     width: self.frame.height-20,
                                     height: self.frame.height-20)
    }
    private func setupTitleLabel() {
        titleLabel.removeFromSuperview()
        titleLabel = NSTextField()
        titleLabel.stringValue = data.getName()
        titleLabel.isBordered = false
        titleLabel.isEditable = false
        titleLabel.isSelectable = false
        titleLabel.font = NSFont.systemFont(ofSize: 20)
        titleLabel.textColor = NSColor.darkGray
        self.addSubview(titleLabel)
    }
    private func layoutTitleLabel() {
        titleLabel.sizeToFit()
        titleLabel.frame.size.width = self.bounds.width/2
        titleLabel.frame.rightTopCorner = CGPoint.init(x: self.frame.width-20, y: self.bounds.height-20)
    }
}
