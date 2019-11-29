//
//  Tree.hpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/26/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef Tree_hpp
#define Tree_hpp

#include <stdio.h>
#include "ArrayList.hpp"

template <typename T>
class Tree {
public:
    class Node {
    public:
        Node() {}
        Node(T data);
        ArrayList<Node*>* children = new ArrayList<Node*>();
        Node* parent = NULL;
        T data;
        void appendNode(Node* node) {
            this->children->append(node);
            node->parent = this;
        }
        void remove();
        int count() {
            return this->children->count();
        }
    };
public:
    char* toString();
    Node* rootNode;
};
#endif /* Tree_hpp */
