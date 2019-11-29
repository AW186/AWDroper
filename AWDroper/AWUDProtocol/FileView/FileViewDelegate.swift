//
//  FileViewDelegate.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 11/18/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

protocol FileViewDelegate: class {
    func enterFolder(data: OCFileTreeNode)
    func tintWillSet()
}
