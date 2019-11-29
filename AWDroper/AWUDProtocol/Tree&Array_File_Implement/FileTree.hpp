//
//  FileTree.hpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/27/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef FileTree_hpp
#define FileTree_hpp

#include "Tree.hpp"
#include <stdio.h>

extern "C" {
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
}
#include "StringOP.hpp"
#include "ArrayList.hpp"

class FileTree: public Tree<char *> {
public:
    FileTree(const char* directoryPath);
    FileTree() {}
    static FileTree* deserializedFromString(const char *str);
    char *toString();
};

#endif /* FileTree_hpp */
