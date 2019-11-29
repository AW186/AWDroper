//
//  Message.cpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/17/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//




#include "Message.hpp"

void* getMessage(int fd, size_t* size) {
    size_t length = 0;
    if(sizeof(length) != read(fd, &length, sizeof(length))) {
        throw noSizeInfo;
    }
    void * buff = malloc(length);
    if (read(fd, buff, length) != length) {
        throw notAbleToReadData;
    }
    *size = length;
    return buff;
}

size_t sendMessage(int fd, const void* buff, size_t size) {
    ssize_t err = 0;
    if((err = write(fd, &size, sizeof(size_t)) != sizeof(size_t))) {
        err < 0 ? []{perror("sendMessage");}() : []{}();
        throw notAbleToWrite;
    }
    if((err = write(fd, buff, size)) < 0) {
        perror("sendMessage");
        throw notAbleToWrite;
    }
    return err;
}
