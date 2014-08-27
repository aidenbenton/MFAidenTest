//
// Created by Aiden Benton on 27/08/2014.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "UIMultiplyButton.h"

@implementation UIMultiplyButton

- (id)init {
    // TODO: is it bad practice not use init here?
    self = [UIButton buttonWithType:UIButtonTypeSystem];
    if (!self) return nil;

    NSLog(@"UIMultiplyButton init");

    self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    [self setTitle:@"X" forState:UIControlStateNormal];

    return self;
}

- (void)setupConstraints:(UIView*)parent
{

}

@end