//
//  Alert.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/15/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
import Cocoa

func alert(question: String, text: String, btns: [String]) -> NSApplication.ModalResponse {
    let alert: NSAlert = NSAlert()
    alert.messageText = question
    alert.informativeText = text
    alert.alertStyle = NSAlert.Style.warning
    btns.forEach { (arg) in
        alert.addButton(withTitle: arg)
    }
    return alert.runModal() 
}
