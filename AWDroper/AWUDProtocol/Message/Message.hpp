//
//  Message.hpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/17/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef Message_hpp
#define Message_hpp

extern "C" {
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>
#include <sys/stat.h>
}

enum MessageError {
    noSizeInfo,
    notAbleToReadData,
    notAbleToWrite
};

void* getMessage(int fd, size_t* size);
size_t sendMessage(int fd, const void* buff, size_t size);
#endif /* Message_hpp */
