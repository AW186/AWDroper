//
//  OCDroperServer.m
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/21/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCDroperServer.h"
#include "DroperServer.hpp"
@implementation OCDroperServer
-(id)init: (NSString*)root {
    self = [super init];
    server = new DroperServer([root UTF8String]);
    ((DroperServer *)server)->processBlk = [](void *captured, float percentage) {
        ((OCDroperServer *)CFBridgingRelease(captured))->processBlk(percentage);
    };
    return self;
}
-(short)startServer {
    return ((DroperServer *)server)->startServer();
}
-(void)closeServer {
    ((DroperServer *)server)->closeServer();
}
-(void *)getServer {
    return self->server;
}
@end
