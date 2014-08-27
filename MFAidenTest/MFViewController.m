//
//  MFViewController.m
//  AidensReactiveTest
//
//  Created by Aiden Benton on 25/08/2014.
//  Copyright (c) 2014 Aiden Benton. All rights reserved.
//

// TODO: Add two inputs
// TODO: Multiplier Button
// TODO: setup Reactive Signal to listen to button and change label
// TODO: Try to copy structure of ui_playground or webviewcontroller
// TODO: Portrait and Landscape

#import "MFViewController.h"
#import "UINumberField.h"

@interface MFViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UINumberField *fieldOne;
@property (nonatomic, strong) UINumberField *fieldTwo;
@property (nonatomic, strong) UIButton *buttonMultiply;
@property (nonatomic, strong) UILabel *labelResult;

@end

@implementation MFViewController

- (instancetype)init {

    self = [super initWithNibName:nil bundle:nil];

    if(self) {
        NSLog(@"MFViewController init");
    }

    return self;
}

- (void)loadView {
    NSLog(@"loadView");
	// Do any additional setup after loading the view, typically from a nib.

    [self setupUI];

    // Logic
    [self setupSignals];
}

- (void) setupUI
{
    // UI
    self.view = [[UIView alloc] init];

    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];

    //setup containers
    UIView *viewContainer = [[UIView alloc] init];
    [self.view addSubview:viewContainer];

    UIView *inputContainer = [[UIView alloc] init];
    [viewContainer addSubview:inputContainer];

    UIView *fieldContainer = [[UIView alloc] init];
    [inputContainer addSubview:fieldContainer];

//    [viewContainer setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];
    UIEdgeInsets padding = UIEdgeInsetsMake(20, 20, 20, 20);
    [viewContainer mas_makeConstraints:^(MASConstraintMaker *make) {

        float min_width = 800;

        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;

        if(screenWidth < screenHeight) {
            min_width = screenWidth;
        } else {
            min_width = screenHeight;
        }


        make.top.equalTo(self.view.mas_top).with.offset(padding.top); //with is an optional semantic filler
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding.bottom);

        make.width.equalTo([NSNumber numberWithFloat:min_width - 40]);
        make.right.lessThanOrEqualTo(self.view.mas_right).with.offset(-padding.right);
    }];

    [inputContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewContainer.mas_top); //with is an optional semantic filler
        make.left.equalTo(viewContainer.mas_left);
        make.right.equalTo(viewContainer.mas_right);

        make.height.greaterThanOrEqualTo(@120);
    }];

    // setup buttonMultiply
    self.buttonMultiply = [UIButton buttonWithType:UIButtonTypeSystem];
    self.buttonMultiply.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    [self.buttonMultiply setTitle:@"X" forState:UIControlStateNormal];
    [inputContainer addSubview:self.buttonMultiply];

    [self.buttonMultiply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputContainer.mas_top); //with is an optional semantic filler
        make.right.equalTo(inputContainer.mas_right);
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(120);
    }];

    // setup fieldOne and fieldTwo
    // would combine much of this into a function to make field styling
    self.fieldOne = [[UINumberField alloc] init];
    self.fieldOne.delegate = self;
    [inputContainer addSubview:self.fieldOne];

    [self.fieldOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(inputContainer);
        make.right.equalTo(self.buttonMultiply.mas_left).with.offset(-20);
    }];

    self.fieldTwo = [[UINumberField alloc] init];
    self.fieldTwo.delegate = self;
    [inputContainer addSubview:self.fieldTwo];

    [self.fieldTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(inputContainer);
        make.right.equalTo(self.buttonMultiply.mas_left).with.offset(-20);
    }];

    // setup labelResult
    self.labelResult = [[UILabel alloc] init];
    self.labelResult.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    self.labelResult.font = [UIFont systemFontOfSize:32];
    self.labelResult.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.labelResult];

    self.labelResult.text = @"Result";

    [self.labelResult mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputContainer.mas_bottom).with.offset(padding.top * 2); //with is an optional semantic filler
        make.right.and.left.equalTo(viewContainer);
        make.height.equalTo(@50);
    }];
}

- (void)setupSignals
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end