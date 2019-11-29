//
//  OCUDProtocol.m
//  AWUDProtocol
//
//  Created by 王子豪 on 2019/8/26.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCUDProtocol.h"

#import "AWUDProtocol.hpp"


@implementation OCUDProtocol : NSObject
-(id)init {
    self = [super init];
    protocol = new AWUDProtocol();
    return self;
}
-(id)init: (NSString *) dst andSrc: (NSString *) src withMethod: (short) method offset: (unsigned long) offset {
    self = [super init];
    protocol = AWUDProtocol::quickInit([dst UTF8String], [src UTF8String], offset, method);
    return self;
}
-(int) runAsClient: (NSString *) addr andPort: (short) port {
    return ((AWUDProtocol *)protocol)->runAsClient([addr UTF8String], port);
}
-(int) runAsServer: (short) port {
    return ((AWUDProtocol *)protocol)->runAsServer(port);
}

@end
