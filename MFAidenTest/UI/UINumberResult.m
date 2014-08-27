//
// Created by Aiden Benton on 27/08/2014.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "UINumberResult.h"


@implementation UINumberResult

-(id)init
{
    self = [super init];
    if(!self) return nil;

    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.font = [UIFont systemFontOfSize:32];
    self.textAlignment = NSTextAlignmentCenter;

    return self;
}
@end