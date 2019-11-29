//
//  OCFileTree.m
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/26/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCFileTree.h"
#include "FileTree.hpp"
#include "DroperServer.hpp"

@implementation OCFileTree {
    
}
-(id)init: (NSString *)serializedString: (Boolean)isPath {
    self = [super init];
    if (isPath) {
        self->tree = new FileTree([serializedString UTF8String]);
    } else {
        self->tree = FileTree::deserializedFromString([serializedString UTF8String]);
    }
    return self;
}
-(OCFileTreeNode *)getRootNode {
    OCFileTreeNode *node = [[OCFileTreeNode alloc] init];
    node->treeNode = ((FileTree *)tree)->rootNode;
    return node;
}
-(void)setTreeByServer: (OCDroperServer *)server {
    self->tree = ((DroperServer *)[server getServer])->getFileTree();
}
@end
