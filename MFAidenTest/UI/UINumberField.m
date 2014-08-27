//
// Created by Aiden Benton on 27/08/2014.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "UINumberField.h"


@implementation UINumberField

- (id)init
{
    self = [super init];
    if (!self) return nil;

    [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
    self.borderStyle = UITextBorderStyleBezel;
    self.font = [UIFont systemFontOfSize:32];
    self.placeholder = @"enter number";
    self.keyboardType = UIKeyboardTypeNumberPad;
    self.returnKeyType = UIReturnKeyNext;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;

    return self;

}

@end