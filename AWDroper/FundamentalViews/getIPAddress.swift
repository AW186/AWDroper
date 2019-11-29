//
//  getIPAddress.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/24/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

enum GetIPError: Error {
    case cannotGetAddrsList
    case noIPv4InList
    var localizedDescription: String {
        switch self {
        case .cannotGetAddrsList:
            return "cannot get the address list"
        case .noIPv4InList:
            return "no ipv4 address in the list"
        }
    }
}
typealias CString = UnsafeMutablePointer<Int8>
func getIPAddress() throws -> String {
    var ifaddrList: UnsafeMutablePointer<ifaddrs>? = nil
    guard getifaddrs(&ifaddrList) == 0 else {
        throw GetIPError.cannotGetAddrsList
    }
    while(ifaddrList != nil) {
        if (ifaddrList?.pointee.ifa_addr.pointee.sa_family == UInt8(PF_INET) &&
            String.init(cString: (ifaddrList?.pointee.ifa_name)!) == "en0") {
            var addr = ifaddrList?.pointee.ifa_addr.pointee
            var hostName = CString.allocate(capacity: Int(NI_MAXHOST))
            defer {
                free(hostName)
            }
            bzero(hostName, Int(NI_MAXHOST))
            if (getnameinfo(&addr!,
                            socklen_t(INET_ADDRSTRLEN),
                            hostName,
                            socklen_t(NI_MAXHOST),
                            nil,
                            socklen_t(0),
                            NI_NUMERICHOST) == 0) {
                
            }
            return String.init(cString: hostName)
        }
        ifaddrList = ifaddrList?.pointee.ifa_next
    }
    throw GetIPError.noIPv4InList
}



























