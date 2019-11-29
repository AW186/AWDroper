//
//  OCUDProtocol.h
//  AWUDProtocol
//
//  Created by 王子豪 on 2019/8/26.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

#ifndef OCUDProtocol_h
#define OCUDProtocol_h

#import <Foundation/Foundation.h>

@interface OCUDProtocol : NSObject {
@private
    void* protocol;
}
-(id)init;
-(id)init: (NSString *) dst andSrc: (NSString *) src withMethod: (short) method offset: (unsigned long) offset;
-(int)runAsClient: (NSString *) addr andPort: (short) port;
-(int)runAsServer: (short) port;
@end

#endif /* OCUDProtocol_h */
