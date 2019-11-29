//
//  HostOrGuest.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/23/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

enum HostOrGuest {
    case host
    case guest
}
enum HostOrGuestLogin {
    case hostLogin(passord: String)
    case guestLogin(ipAddress: String, port: CShort, passord: String)
}
