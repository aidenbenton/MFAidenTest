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
    self.delegate = self;

    return self;

}

- (BOOL) textField: (UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString: (NSString *)string {
//return yes or no after comparing the characters

    // allow backspace
    if (!string.length)
    {
        return YES;
    }

    // allow digit 0 to 9
    if ([string intValue])
    {
        return YES;
    }

    return NO;
}

@end