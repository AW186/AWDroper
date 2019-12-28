//
//  FileTreeNode.hpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/27/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef FileTreeNode_hpp
#define FileTreeNode_hpp

#include "FileTree.hpp"
#include "Tree.hpp"
#include "AWFileInfo.hpp"
extern "C" {
    #include <stdio.h>
    #include <dirent.h>
}
enum CreatNodeError {
    notFileOrDirectory,
    notDirectory
};
    
class FileTreeNode: public Tree<AWFileInfo>::Node {
public:
    FileTreeNode();
    FileTreeNode(const char* path);
    static FileTreeNode* deserializedFromString(const char *str);
    char * toString();
    char * toPath();
    char * toAbsPath();
private:
    FileTreeNode(dirent* file, const char* directory);
};

#endif /* FileTreeNode_hpp */
