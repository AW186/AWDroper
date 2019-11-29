//
//  LoginServer.h
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/25/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef LoginServer_h
#define LoginServer_h

#include <unistd.h>
#include "FileTree.hpp"
#include "DroperServer.hpp"

class DroperServer {
private:
    pid_t pid = -1;
    FileTree* fileTree = NULL;
public:
    void (*processBlk)(void* captured, float percentage) = NULL;
    DroperServer(const char *path);
    DroperServer(FileTree* tree);
    ~DroperServer();
    FileTree* getFileTree();
    short startServer(); //return avaliable port, return -1 if failed
    void closeServer();
};

#endif /* LoginServer_h */





















