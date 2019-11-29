//
//  AWUDProtocol.cpp
//  AWUDProtocol
//
//  Created by Zihao Arthur Wang [STUDENT] on 8/21/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#include "AWUDProtocol.hpp"

void AWUDProtocol::zero() {
    this->header = Header();
    this->info = Info();
    this->localFilePath = NULL;
}

int AWUDProtocol::runAsServer(short port) {
    auto blk = [](void* captured, int sockfd, struct sockaddr addr, socklen_t socklen) {
        ((AWUDProtocol *)captured)->serverTask(sockfd, addr, socklen);
    };
    server(port, this, blk);
    return 0;
}

int AWUDProtocol::runAsClient(const char* addr, short port) {
    auto blk = [](void* captured, int sockfd) {
        ((AWUDProtocol *)captured)->clientTask(sockfd);
    };
    client(addr, port, this, blk);
    return 0;
}

int AWUDProtocol::clientTask(int sockfd) {
    this->sendHeader(sockfd);
    switch (this->header.method) {
        case UPLOAD:
            if(this->sendInfo(sockfd) < 0)
                return -1;
            if(this->recvInfo(sockfd) < 0)
                return -1;
            if(this->sendBody(sockfd, localFilePath) < 0)
                return -1;
            break;
        case DOWNLOAD:
            if(this->recvInfo(sockfd) < 0)
                return -1;
            if(this->sendInfo(sockfd) < 0)
                return -1;
            if(this->recvBody(sockfd, localFilePath) < 0)
                return -1;
            break;
        default:
            break;
    }
    return 0;
}

int AWUDProtocol::serverTask(int sockfd, struct sockaddr addr, socklen_t socklen) {
    this->recvHeader(sockfd);
    switch (this->header.method) {
        case UPLOAD:
            if(this->recvInfo(sockfd) < 0)
                return -1;
            if(this->sendInfo(sockfd) < 0)
                return -1;
            if(this->recvBody(sockfd, header.path) < 0)
                return -1;
            break;
        case DOWNLOAD:
            if(this->sendInfo(sockfd) < 0)
                return -1;
            if(this->recvInfo(sockfd) < 0)
                return -1;
            if(this->sendBody(sockfd, header.path) < 0)
                return -1;
            break;
        default:
            break;
    }
    return 0;
}

int AWUDProtocol::sendHeader(int fd) {
    ssize_t size;
    printf("header.length: %zu\n", this->header.length);
    size_t length = htonl(this->header.length);
    printf("header.length: %u\n", ntohl(length));
    if ((size = write(fd, &length, sizeof(length))) < 0) {
        perror("write");
        return -1;
    }
    if ((size = write(fd, this->header.path, this->header.length)) < 0) {
        perror("write");
        return -1;
    }
    short method = htons(this->header.method);
    if ((size = write(fd, &method, sizeof(method))) < 0) {
        perror("write");
        return -1;
    }
    return 0;
}

int AWUDProtocol::recvHeader(int fd) {
    ssize_t size;
    if ((size = read(fd, &this->header.length, sizeof(header.length))) <= 0) {
        return size < 0 ? -1 : -2;
    }
    header.length = ntohl(header.length);
    printf("header.length: %zu\n", this->header.length);
    this->header.path = (char *)malloc(header.length);
    if ((size = read(fd, header.path, header.length)) <= 0) {
        return size < 0 ? -1 : -2;
    }
    printf("header.path: %s", this->header.path);
    if ((size = read(fd, &header.method, sizeof(header.method))) <= 0) {
        return size < 0 ? -1 : -2;
    }
    header.method = ntohs(header.method);
    return 0;
}

int AWUDProtocol::sendInfo(int fd) {
    ssize_t size;
    size_t fileSize = htonl(this->info.fileSize);
    if ((size = write(fd, &fileSize, sizeof(fileSize))) < 0) {
        perror("write");
        return -1;
    }
    size_t offset = htonl(this->info.offset);
    if ((size = write(fd, &offset, sizeof(offset))) < 0) {
        perror("write");
        return -1;
    }
    return 0;
}

int AWUDProtocol::recvInfo(int fd) {
    ssize_t size;
    if ((size = read(fd, &(this->info.fileSize), sizeof(this->info.fileSize))) < 0) {
        perror("read");
        return -1;
    }
    this->info.fileSize = ntohl(info.fileSize);
    if ((size = read(fd, &(this->info.offset), sizeof(this->info.offset))) < 0) {
        perror("read");
        return -1;
    }
    this->info.offset = ntohl(info.offset);
    return 0;
}

int AWUDProtocol::sendBody(int sockfd, const char* path) {
    int fd = open(path, O_RDWR);
    if (fd < 0) {
        perror("open");
        return 1;
    }
    struct stat stats;
    fstat(fd, &stats);
    printf("size: %lld\n", stats.st_size);
    write(sockfd, &stats.st_size, sizeof(stats.st_size));
    lseek(fd, this->info.offset, SEEK_SET);
    printf("offset: %zu", info.offset);
    while(true) {
        off_t len = 32*1024;
        unsigned long size;
        char *buff = (char *)malloc(len);
        if (0 >= (size = read(fd, buff, len))) {
            break;
        }
        printf("read from file: %s, with size: %lu\n", buff, size);
        write(sockfd, buff, size);
    }
    close(fd);
    return 0;
}

int AWUDProtocol::recvBody(int sockfd, const char* path) {
    long size;
    read(sockfd, &size, sizeof(size));
    size = ntohl(size);
    int flag = 0;
    unsigned long offset = this->info.offset;
    flag = offset > 0 ? (O_WRONLY | O_APPEND | O_CREAT) : (O_WRONLY | O_CREAT | O_TRUNC);
    int fd = offset > 0 ? open(path, flag) : open(path, flag, 0777);
    if (fd == -1) {perror("open");}
    char *buff = (char *)malloc(32*1024);
    long exits;
    while((exits = read(sockfd, buff, 32*1024)) > 0) {
        printf("information read: %s with size: %lu\n", buff, exits);
        write(fd, buff, exits);
        offset += exits;
    }
    if(exits == -1) {
        perror("Socket connection");
    }
    close(fd);
    return 0;
}





