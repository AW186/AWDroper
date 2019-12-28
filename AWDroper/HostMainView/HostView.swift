//
//  HostMainView.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/21/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

class HostView: NSView {
    private var selectFileView              = SelectFileView()
    private var headerView: HeaderView      = HeaderView()
    private var ipLabel: NSTextField        = NSTextField()
    private var passordLabel: NSTextField   = NSTextField()
    private var bottomView: BottomView
    private var contentView: HostFileTableView
    weak var delegate: HostViewDelegate?
    let data: OCFileTreeNode
    var port: CShort                        = 0
    var passord: String                     = ""
    var ipAddress: String                   = ""
    init(data: OCFileTreeNode) {
        self.data = data
        self.bottomView = BottomView(data: data)
        print("Name of root: "+data.getName())
        contentView = HostFileTableView(data: data)
        super.init(frame: CGRect.zero)
    }
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HostView {
    func refreshCurrentDirectory() {
        contentView.reload()
    }
    override func viewDidMoveToSuperview() {
        super.viewDidMoveToSuperview()
        setupContentView()
        setupSelectFileView()
        setupBottomView()
        setupHeaderView()
        setupIPLabel()
        setupPassordLabel()
    }
    override func layout() {
        super.layout()
        layoutHeaderView()
        layoutIPLabel()
        layoutPassordLabel()
        layoutBottomView()
        layoutSelectFileView()
        layoutContentView()
    }
}

extension HostView {
    private func layoutSelectFileView() {
        selectFileView.frame = self.bounds
        selectFileView.frame.size.width = 100
        selectFileView.frame.size.height -= self.headerView.height+self.bottomView.height
        selectFileView.frame.origin.y += self.bottomView.height
    }
    private func setupSelectFileView() {
        selectFileView.removeFromSuperview()
        selectFileView.delegate = self
        self.addSubview(selectFileView)
    }
    private func setupBottomView() {
        bottomView.removeFromSuperview()
        bottomView.delegate = self
        self.addSubview(bottomView)
    }
    private func layoutBottomView() {
        bottomView.layoutInBounds(self.bounds)
    }
    private func setupContentView() {
        contentView.removeFromSuperview()
        contentView.enterFolderBlk = { [unowned self] (arg) in
            self.bottomView.data = arg
        }
        self.addSubview(contentView)
    }
    private func layoutContentView() {
        contentView.frame = self.bounds
        contentView.frame.size.height -= headerView.height+bottomView.height
        contentView.frame.origin.y += bottomView.height
        contentView.frame.size.width -= selectFileView.frame.width
        contentView.frame.origin.x += selectFileView.frame.width
    }
    private func setupHeaderView() {
        headerView.removeFromSuperview()
        headerView.title = "Host"
        headerView.recallBlk = { [unowned self] in
            self.delegate?.back()
        }
        self.addSubview(headerView)
    }
    private func layoutHeaderView() {
        self.wantsLayer = true
        headerView.layoutInBounds(self.bounds)
    }
    private func setupIPLabel() {
        ipLabel.removeFromSuperview()
        do {
            let ipAddr = try getIPAddress()
            ipLabel.stringValue = "IP: "+ipAddr+" Port: \(port)"
        } catch let err as GetIPError {
            print(err.localizedDescription)
        } catch { }
        ipLabel.isBordered  = false
        ipLabel.isEditable  = false
        ipLabel.isEditable  = false
        ipLabel.textColor   = NSColor.darkGray
        ipLabel.font        = NSFont.systemFont(ofSize: 16)
        ipLabel.alignment   = .center
        headerView.addSubview(ipLabel)
    }
    private func layoutIPLabel() {
        ipLabel.sizeToFit()
        ipLabel.frame.rightTopCorner = CGPoint(x: headerView.bounds.width-20,
                                               y: headerView.bounds.height-20)
    }
    private func setupPassordLabel() {
        passordLabel.removeFromSuperview()
        passordLabel.isBordered     = false
        passordLabel.isSelectable   = false
        passordLabel.isEditable     = false
        passordLabel.stringValue    = "Passord: "+self.passord
        passordLabel.textColor      = NSColor.darkGray
        passordLabel.font           = NSFont.systemFont(ofSize: 16)
        passordLabel.alignment      = .center
        headerView.addSubview(passordLabel)
    }
    private func layoutPassordLabel() {
        passordLabel.sizeToFit()
        passordLabel.frame.rightTopCorner = ipLabel.frame.rightBottomCorner
            .minus(point: CGPoint(x: 0, y: 5))
    }
}
extension HostView: BottomViewDelegate {
    func checkProcess() {
        
    }
    func backToPreviousDirectory() {
        let data = contentView.data.getSuper()
        contentView.data = data!
        bottomView.data = data!
    }
}
extension HostView: SelectFileViewDelegate {
    func fileDidOpened(url: URL) {
        if copyFileToCurrentDirectory(url: url) {
            appendFile(url: url)
            refreshCurrentDirectory()
        }
    }
    func appendFile(url: URL) {
        contentView.data.appendData(url.lastPathComponent, Int8(DT_REG))
    }
    private func copyFileToCurrentDirectory(url: URL) -> Bool {
        var path = url.absoluteString
        path.removeFirst(7)
        guard let fd = fopen(path, "r") else {
            perror("open "+path)
            if errno == 35 {
                _ = alert(question: "Currently not supporting fileName what contains space", text: "you file: "+path, btns: ["confirm"])
            }
            return false
        }
        var number = 0
        while(FileManager.default.fileExists(atPath: contentView.data.getAbsPath()+"/"+(number > 0 ? "\(number)" : "")+url.lastPathComponent)) {
            number += 1
        }
        let dstPath = contentView.data.getAbsPath()+"/"+(number > 0 ? "\(number)" : "")+url.lastPathComponent
        guard let dst = fopen(dstPath, "w") else {
            perror("open "+dstPath)
            return false
        }
        var bytesIn: Int
        let buffer = malloc(1024)
        bzero(buffer, 1024)
        repeat {
            bytesIn = fread(buffer, 1, 1024, fd)
            fwrite(buffer, 1, bytesIn, dst)
        } while(bytesIn > 0)
        free(buffer)
        fclose(dst)
        fclose(fd)
        return true
    }
}













