//
//  FileArray.hpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/27/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef FileArray_hpp
#define FileArray_hpp

#include "ArrayList.hpp"
#include <stdio.h>
#include <stdlib.h>

class FileArray: ArrayList<char *> {
    ~FileArray() {
        Node* nNode;
        for(Node* node = this->rootNode; node != nullptr; node = nNode) {
            nNode = node->nextNode;
            free(node->data);
            delete node;
        }
    }
};

#endif /* FileArray_hpp */
