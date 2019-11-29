//
//  LoginServer.c
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/25/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#include "DroperServer.hpp"
#include "Sockets.hpp"
#include "AWUDProtocol.hpp"
#include "Message.hpp"
#include <signal.h>
#define MAX_PASSORD_LENGTH 32

DroperServer::DroperServer(FileTree* tree) {
    this->fileTree = tree;
}

DroperServer::DroperServer(const char *path) {
    this->fileTree = new FileTree(path);
}

DroperServer::~DroperServer() {
    delete this->fileTree;
}

short DroperServer::startServer() {
    if ((this->pid = fork()) != 0) {
        return -1;
    }
    short port = 7000;
    ServerTask* previousTask = new ServerTask(fileTree, [](void* captured, int sockfd, struct sockaddr saddr, socklen_t socklen) {
        char *buff = ((FileTree *)captured)->toString();
        sendMessage(sockfd, buff, strlen(buff));
    });
    ServerTask* task = new ServerTask(nullptr, [](void* captured, int sockfd, struct sockaddr saddr, socklen_t socklen) {
        AWUDProtocol* protocol;
        do {
            protocol = new AWUDProtocol();
        } while(protocol->serverTask(sockfd, saddr, socklen) != -1);
    });
    task->preTask = previousTask;
    for (short port = 7000; server(port, task) != 0; port++) {
        if (port > 8000) {
            return -1;
        }
    };
    return port;
}

FileTree* DroperServer::getFileTree() {
    return this->fileTree;
}

void DroperServer::closeServer() {
//    kill(this->pid, 9);
}


















