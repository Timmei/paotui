//
//  Request.h
//  JifenCustomer
//
//  Created by Jiangzhou on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

//#import "JSONKit.h"
#import <Foundation/Foundation.h>

@interface Base : NSObject

+(NSString *)serializeObject:(id)object withBaseClass:(id)class;
+(id) parseDictionary: (NSDictionary *) dictionary withObject:(id)object withBaseClass:(id)class;

@end
