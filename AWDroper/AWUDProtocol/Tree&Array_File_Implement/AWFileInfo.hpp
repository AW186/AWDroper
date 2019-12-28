//
//  FileInfo.hpp
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 12/10/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef FileInfo_hpp
#define FileInfo_hpp

#include <stdio.h>
#include "stdlib.h"

typedef struct AWFileInfo {
    AWFileInfo() {
        name = (char *)malloc(1);
    }
    AWFileInfo(const char *name, char type);
    AWFileInfo(const char *string);
    char *name = "\0";
    char type = 4;
    char *toString();
} AWFileInfo;

#endif /* FileInfo_hpp */
