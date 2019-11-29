//
//  Tree.swift
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/24/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation

indirect enum Tree<T> {
    case node(data: T, subtrees: [Tree<T>], parent: Tree<T>)
    case leaf(data: T, parent: Tree<T>)
    case none
}
typealias FileTree = Tree<String>
extension Tree where T == String {
    func toString() -> String {
        switch self {
        case .node(let data, _, let parent):
            if case .none = parent {
                return data
            }
            return parent.toString()+"/"+data
        case .leaf(let data, let parent):
            if case .none = parent {
                return data
            }
            return parent.toString()+"/"+data
        default:
            return ""
        }
    }
}
