//
//  OCDroperServer.h
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/21/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef OCDroperServer_h
#define OCDroperServer_h
@interface OCDroperServer: NSObject {
    void* server;
    void(^processBlk)(float percentage);
}
-(void *)getServer;
-(id)init: (NSString *)root;
-(short)startServer;
-(void)closeServer;
@end
#endif /* OCDroperServer_h */
