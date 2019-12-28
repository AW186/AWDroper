//
//  OCFileTreeNode.m
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/30/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OCFileTreeNode.h"
#include "FileTreeNode.hpp"
#include "StringOP.hpp"
#define NODE ((FileTreeNode *)self->treeNode)

@implementation OCFileTreeNode  {
    
}
-(OCFileTreeNode *)getSuperNode {
    if (NODE->parent != NULL) {
        OCFileTreeNode *retval = [[OCFileTreeNode alloc] init];
        retval->treeNode = NODE->parent;
        return retval;
    }
    return self;
}
-(NSMutableArray<OCFileTreeNode *> *)getChildren {
    NSMutableArray<OCFileTreeNode *> *retval =
    [[NSMutableArray<OCFileTreeNode *> alloc] init];
    auto currentNode = NODE->children->rootNode->nextNode;
    while(currentNode != NULL) {
        OCFileTreeNode *node = [[OCFileTreeNode alloc] init];
        node->treeNode = currentNode->data;
        [retval addObject: node];
        currentNode = currentNode->nextNode;
    }
    return retval;
}
-(char)getType {
    return  NODE->getData().type;
}
-(NSString *)getName {
    return [NSString stringWithCString: NODE->getData().name
                              encoding: NSUTF8StringEncoding];
}
-(NSString *)getPath {
    return [NSString stringWithCString: NODE->toPath()
                              encoding: NSUTF8StringEncoding];
}
-(NSString *)getAbsPath {
    return [NSString stringWithCString: NODE->toAbsPath()
                              encoding: NSUTF8StringEncoding];
}
-(void)remove {
    NODE->removeTreeFromParent();
}
-(void)append: (OCFileTreeNode *) node {
    NODE->appendNode((FileTreeNode *)(node->treeNode));
}
-(void)rename: (NSString *) name {
    char type = NODE->getData().type;
    NODE->setData(AWFileInfo([name UTF8String], type));
}
-(void)appendData: (NSString *) name : (char) type {
    FileTreeNode *node = new FileTreeNode();
    node->setData(AWFileInfo([name UTF8String], type));
    NODE->appendNode(node);
}

@end
