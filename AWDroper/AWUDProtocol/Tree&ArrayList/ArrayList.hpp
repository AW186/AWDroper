
//
//  ArrayList.hpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/26/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef ArrayList_hpp
#define ArrayList_hpp

#include <stdio.h>
template <typename T>
class ArrayList {
public:
    class Node {
    public:
        Node* previousNode = NULL;
        Node* nextNode = NULL;
        T data;
        Node() {}
        Node(T data) {
            this->data = data;
        }
        void remove() {
            if (this->nextNode != nullptr) {
                nextNode->prelink(this->previousNode);
            } else {
                this->previousNode->nextNode = NULL;
            }
            delete this;
        }
        void prolink(Node* node) {
            if (node != NULL) {
                node->previousNode = this;
            }
            this->nextNode = node;
        }
        void prelink(Node* node) {
            if (node != NULL) {
                node->nextNode = this;
            }
            this->previousNode = node;
        }
    };
    ~ArrayList() {
        Node* nNode;
        for(Node* node = this->rootNode; node != nullptr; node = nNode) {
            nNode = node->nextNode;
            delete node;
        }
    }
    Node* rootNode = new Node();
    void append(T data) {
        Node* node = new Node(data);
        node->prolink(this->rootNode->nextNode);
        node->prelink(this->rootNode);
    }
    int removeChild(T data) {
        for(Node* node = rootNode; node != nullptr; node = node->nextNode) {
            if (node->data == data) {
                node->remove();
                return 0;
            }
        }
        return 1;
    }
    int removeAt(int index);
    int insert(T data, int index);
    int append(ArrayList<T> list);
    int insert(ArrayList<T> list, int index);
    int count() {
        int count = 0;
        for(Node* node = this->rootNode->nextNode; node != NULL; node = node->nextNode) {
            count++;
        }
        return count;
    }
    void forEach(void (*pf)(T));
    void forEachNode(void (*pf)(Node*));
};
#endif /* ArrayList_hpp */
