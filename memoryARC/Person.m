//
//  Person.m
//  memoryARC
//
//  Created by xwwang_0102 on 16/2/11.
//  Copyright © 2016年 xwwang_0102. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)copyWithZone:(NSZone *)zone
{
    Person *copy =  [[[self class] allocWithZone: zone] init];
    
    copy.name = _name;
    [copy setFromWhere:@"兰州"];
    copy.age = _age;
    return copy;
}


- (id)mutableCopyWithZone:(NSZone *)zone
{
    Person *copy =  [[[self class] allocWithZone: zone] init];
    
    copy.name = _name;
    [copy setFromWhere:@"兰州"];
    copy.age = _age;
    return copy;
}


@end
