//
//  AWUDProtocol.hpp
//  AWUDProtocol
//
//  Created by Zihao Arthur Wang [STUDENT] on 8/21/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef AWUDProtocol_hpp
#define AWUDProtocol_hpp

#include <stdio.h>
extern "C" {
    #include <stdlib.h>
    #include <unistd.h>
    #include <string.h>
    #include <fcntl.h>
    #include <sys/stat.h>
}
#include "Sockets.hpp"
#include "SocketTask.hpp"
#define UPLOAD          0
#define DOWNLOAD        1
#define CONNECT_OFF     -1
#define SYSTEM_ERROR    -2

class AWUDProtocol {
public:
    typedef struct Header {
        size_t  length  = 0;
        char    *path   = (char *)malloc(1);
        short   method  = 0;
        Header() { }
        Header(size_t length, const char *path, short method) {
            this->length        = length;
            this->path          = (char *)malloc(length);
            memcpy(this->path, path, length);
            this->method        = method;
        }
        ~Header() {
            free(path);
        }
    } Header;
    typedef struct Info {
        Info(size_t fileSize, size_t offset) {
            this->fileSize  = fileSize;
            this->offset    = offset;
        }
        Info() {}
        size_t fileSize = 0;
        size_t offset = 0;
    } Info;
    /* may not be totally complete when initialized,
     but will be complete during the socket communication */
    int runAsServer(short port);
    int runAsClient(const char* addr, short port);
    int serverTask(int sockfd, struct sockaddr addr, socklen_t socklen);
    int clientTask(int sockfd);
    void (*processBlk)(void *captured, float percentage) = NULL;
    AWUDProtocol(Header header, Info info, const char *localFilePath) {
        this->header = header;
        this->info = info;
        size_t length = strlen(localFilePath)+1;
        this->localFilePath = (char *)malloc(length);
        memcpy(this->localFilePath, localFilePath, length);
    }
    static AWUDProtocol* quickInit(const char* dst, const char* src, size_t offset, short method) {
        char* srcfile = (char *)malloc(strlen(src)+1);
        bzero(srcfile, strlen(src)+1);
        memcpy(srcfile, src, strlen(src));
        char* dstfile = (char *)malloc(strlen(dst)+1);
        bzero(dstfile, strlen(dst)+1);
        memcpy(dstfile, dst, strlen(dst));
        AWUDProtocol *protocol = new AWUDProtocol(AWUDProtocol::Header(strlen(srcfile), srcfile, method), AWUDProtocol::Info(0, offset), dstfile);
        return protocol;
    }
    AWUDProtocol() {
        this->header = Header();
        this->info = Info();
        this->localFilePath = NULL;
    }
    void zero();
    ~AWUDProtocol() {
        free(this->localFilePath);
    }
private:
    Header header;
    Info info;
    char *localFilePath;
    
    int sendHeader(int fd);
    int recvHeader(int fd);
    int sendInfo(int fd);
    int recvInfo(int fd);
    int sendBody(int sockfd, const char *path);
    int recvBody(int sockfd, const char *path);
    void (*recvHandler)(char *buff, size_t length, size_t offset, size_t totalSize);
    void (*sendHandler)(size_t length, size_t offset, size_t totalSize);
};

#endif /* AWUDProtocol_hpp */
