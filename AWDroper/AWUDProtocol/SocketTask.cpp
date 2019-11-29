//
//  SocketTask.cpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/20/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#include "SocketTask.hpp"

SocketTask::SocketTask(void* captured,
                       void (*task)(void* captured, int sockfd, struct sockaddr saddr, socklen_t socklen)){
    this->captured = captured;
    this->task = task;
}

void SocketTask::executeServer(int sockfd, struct sockaddr saddr, socklen_t socklen) {
    if (preTask != NULL) {
        preTask->executeServer(sockfd, saddr, socklen);
    }
    this->task(captured, sockfd, saddr, socklen);
}


