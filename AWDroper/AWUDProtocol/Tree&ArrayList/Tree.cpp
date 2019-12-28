//
//  Tree.cpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/26/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#include "Tree.hpp"
template <typename T>
Tree<T>::Node::Node(T data) {
    this->data = data;
}

//template <typename T>
//void Tree<T>::Node::appendNode(Node* node) {
//    this->children->append(node);
//    node->parent = this;
//}

//template <typename T>
//void Tree<T>::Node::remove() {
//    this->parent->children->forEachNode([=](Node* node)->void {
//        if (node->data == this->data) {
//            node->remove();
//        }
//    });
//}
//template <typename T>
//int Tree<T>::Node::count() {
//    return this->children->count();
//}


