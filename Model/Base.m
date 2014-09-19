//
//  Request.m
//  JifenCustomer
//
//  Created by Jiangzhou on 12-9-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Base.h"

#import <Foundation/NSObjCRuntime.h>
#import <objc/runtime.h>

@implementation Base


+(void) fillDictory:(NSMutableDictionary*)dic withObject:(id)object withCls:(id)cls{
    NSString *propertyName;
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        propertyName = [NSString stringWithUTF8String:property_getName(property)];
        SEL selector = NSSelectorFromString(propertyName);
        id value=[object performSelector:selector];
        if (value==nil) {
            [dic setValue: [NSNull null] forKey:propertyName];
        }else {
            if ([value isKindOfClass:[NSArray class]]) {
                NSArray *_a = value;
                if ([_a count]>0) {
                    if ([[_a objectAtIndex:0] isKindOfClass:[NSString class]]) {
                        [dic setValue:value forKey:propertyName];
                    }
                }
                continue;
            }
            [dic setValue:value forKey:propertyName];
        }
    }
    free(properties);
}
//+ (NSString *)serializeObject:(id)object withBaseClass:(id)class{
//    NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithCapacity:0];
//    
//    id currentClass = [object class];
//    [self fillDictory:dic withObject:object withCls:currentClass];
//    if (class) {
//        [self fillDictory:dic withObject:object withCls:class];
//    }
//    return [dic JSONString];
//}
+ (id)parseDictionary:(NSDictionary *)dictionary withObject:(id)object withBaseClass:(id)class{
    id currentClass = [object class];
    NSString *propertyName;
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(currentClass, &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        propertyName = [NSString stringWithUTF8String:property_getName(property)];
        id value=[dictionary valueForKey:propertyName];
        if (value == nil) {
            continue;
        }
        if ([value isKindOfClass:[NSArray class]]) {
            continue;
        }
        [object setValue:value forKey:propertyName];
    }
    free(properties);
    if (class) {
        properties = class_copyPropertyList(class, &outCount);
        
        for (i = 0; i < outCount; i++) {
            objc_property_t property = properties[i];
            fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
            propertyName = [NSString stringWithUTF8String:property_getName(property)];
            id value=[dictionary valueForKey:propertyName];
            if (value == nil) {
                continue;
            }
            if ([value isKindOfClass:[NSArray class]]) {
                continue;
            }
            [object setValue:value forKey:propertyName];
        }
        free(properties);
    }
    return object;
}

@end
