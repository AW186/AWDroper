//
//  OCFileTree.h
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/26/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef OCFileTree_h
#define OCFileTree_h
#import "OCFileTreeNode.h"
#import "OCDroperServer.h"


@interface OCFileTree: NSObject {
    void *tree;
}
-(id)init: (NSString *)serializedString: (Boolean)isPath;
-(OCFileTreeNode *)getRootNode;
-(void)setTreeByServer: (OCDroperServer *)server;
@end
#endif /* OCFileTree_h */
