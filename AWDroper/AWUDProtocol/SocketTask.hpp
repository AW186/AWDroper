//
//  SocketTask.hpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/20/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef SocketTask_hpp
#define SocketTask_hpp

#include <stdio.h>
extern "C" {
#include <sys/socket.h>
#include <unistd.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <signal.h>
}
class SocketTask {
public:
    SocketTask* preTask = NULL;
    void* captured = NULL;
    void (*task)(void* captured, int sockfd, struct sockaddr saddr, socklen_t socklen) = NULL;
    SocketTask(void* captured,
               void (*task)(void* captured, int sockfd, struct sockaddr saddr, socklen_t socklen));
    void executeClient(int sockfd);
    void executeServer(int sockfd, struct sockaddr saddr, socklen_t socklen);
};

#endif /* SocketTask_hpp */
