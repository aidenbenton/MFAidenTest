//
// Created by Aiden Benton on 27/08/2014.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "UINumberField.h"


@interface UINumberField ()  <UITextFieldDelegate>
@end

@implementation UINumberField

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
        self.borderStyle = UITextBorderStyleBezel;
        self.font = [UIFont systemFontOfSize:32];
        self.placeholder = @"enter number";
        self.keyboardType = UIKeyboardTypeNumberPad;
        self.returnKeyType = UIReturnKeyNext;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        self.delegate = self;
    }
    return self;

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *blacklistedCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    if ([string rangeOfCharacterFromSet:blacklistedCharacterSet].location != NSNotFound) {
        return NO;
    }

    return YES;
}

@end