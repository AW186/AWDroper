//
//  OCFileTreeNode.h
//  AWDroper
//
//  Created by Zihao Arthur Wang [STUDENT] on 10/30/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef OCFileTreeNode_h
#define OCFileTreeNode_h

@interface OCFileTreeNode: NSObject {
    @public void* treeNode;
}
-(NSMutableArray<OCFileTreeNode *> *)getChildren;
-(NSString *)getName;
-(NSString *)getPath;
-(OCFileTreeNode *)getSuperNode;
@end

#endif /* OCFileTreeNode_h */
