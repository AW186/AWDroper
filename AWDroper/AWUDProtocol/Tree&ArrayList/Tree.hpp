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
#include "stdlib.h"

template <typename T>
class Tree {
public:
    class Node {
    private:
        T *data = nullptr;
    public:
        Node() {}
        Node(T data);
        ArrayList<Node*>* children = new ArrayList<Node*>();
        Node* parent = NULL;
        T getData() {
            return data[0];
        }
        void setData(T newData) {
            free(data);
            data = (T *)malloc(sizeof(T));
            data[0] = newData;
         }
        void appendNode(Node* node) {
            this->children->append(node);
            node->parent = this;
        }
        void removeSubtree(Node* subNode) {
            this->children->removeChild(subNode);
        }
        void removeTreeFromParent() {
            this->parent->removeSubtree(this);
            this->parent = NULL;
        }
        int count() {
            return this->children->count();
        }
    };
public:
    char* toString();
    Node* rootNode;
};
#endif /* Tree_hpp */
