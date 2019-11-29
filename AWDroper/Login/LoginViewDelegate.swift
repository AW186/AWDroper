//
//  LoginViewDelegate.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/15/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

protocol LoginViewDelegate: class {
    func login(status: HostOrGuestLogin)
    func back()
}
