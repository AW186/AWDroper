//
//  StringOP.cpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 9/28/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#include "StringOP.hpp"

extern "C" {
    #include <stdlib.h>
    #include <string.h>
}

char * copy(const char *src) {
    if (src == nullptr) {
        return "\0";
    }
    char *buff = (char *)malloc(strlen(src)+1);
    bzero(buff, strlen(src)+1);
    memcpy(buff, src, strlen(src));
    return buff;
}

char * copy(const char *src, int offset, int length) {
    if (src == nullptr) {
        return "\0";
    }
    char *buff = (char *)malloc(length+1);
    bzero(buff, length+1);
    memcpy(buff, src+offset, length);
    return buff;
}

