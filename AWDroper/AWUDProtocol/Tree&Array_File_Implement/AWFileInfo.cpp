//
//  AWFileInfo.cpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 12/10/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#include "AWFileInfo.hpp"
#include "StringOP.hpp"
extern "C" {
#include "stdlib.h"
#include "string.h"
#include <stdio.h>
#include <dirent.h>
}

AWFileInfo::AWFileInfo(const char *name, char type) {
    this->name = copy(name);
    this->type = type;
}
AWFileInfo::AWFileInfo(const char *string) {
    size_t size = strlen(string)-1;
    this->name = (char *)malloc(size);
    bzero(this->name, size);
    memcpy(this->name, string, size-1);
    this->type = string[size-2] == 'd' ? DT_DIR : DT_REG;
}
char *AWFileInfo::toString() {
    size_t size = strlen(name)+2;
    char *retval = (char *)malloc(size);
    bzero(retval, size);
    memcpy(retval, name, size-2);
    retval[size-2] = type == DT_DIR ? 'd' : 'f';
    return retval;
}
