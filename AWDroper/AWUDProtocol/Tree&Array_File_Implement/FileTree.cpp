//
//  FileTree.cpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/27/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#include "FileTree.hpp"
#include <fcntl.h>
#include <dirent.h>
#include "FileTreeNode.hpp"

FileTree::FileTree(const char *directoryPath) {
    this->rootNode = (Tree<AWFileInfo>::Node *)(new FileTreeNode(directoryPath));
}

char * FileTree::toString() {
    return ((FileTreeNode *)(this->rootNode))->toString();
}

FileTree* FileTree::deserializedFromString(const char *str) {
    FileTree* retval = new FileTree();
    retval->rootNode = FileTreeNode::deserializedFromString(str);
    return retval;
}
