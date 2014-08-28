//
//  MFViewController.m
//  AidensReactiveTest
//
//  Created by Aiden Benton on 25/08/2014.
//  Copyright (c) 2014 Aiden Benton. All rights reserved.
//

#import "MFViewController.h"
#import "UINumberField.h"
#import "UIMultiplyButton.h"
#import "UINumberResult.h"

@interface MFViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UINumberField *firstField;
@property (nonatomic, strong) UINumberField *secondField;
@property (nonatomic, strong) UIMultiplyButton *multiplyButton;
@property (nonatomic, strong) UINumberResult *resultLabel;

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

    [self setupUI];
    [self setupSignals];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view, typically from a nib or loadView method.
}

- (void) setupUI
{
    self.view = [[UIView alloc] init];

    [self.view setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3]];

    //setup containers
    UIView *viewContainer = [[UIView alloc] init];
    [self.view addSubview:viewContainer];

    UIView *inputContainer = [[UIView alloc] init];
    [viewContainer addSubview:inputContainer];

    UIView *fieldContainer = [[UIView alloc] init];
    [inputContainer addSubview:fieldContainer];

    UIEdgeInsets padding = UIEdgeInsetsMake(20, 20, 20, 20);
    [viewContainer mas_makeConstraints:^(MASConstraintMaker *make) {

        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = CGRectGetWidth(screenRect);
        CGFloat screenHeight = CGRectGetHeight(screenRect);

        float min_width;
        if(screenWidth < screenHeight) {
            min_width = screenWidth;
        } else {
            min_width = screenHeight;
        }

        make.top.equalTo(self.view.mas_top).with.offset(padding.top * 2); //with is an optional semantic filler
        make.left.equalTo(self.view.mas_left).with.offset(padding.left);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-padding.bottom);

        make.width.equalTo(@(min_width - 40));
        make.right.lessThanOrEqualTo(self.view.mas_right).with.offset(-padding.right);
    }];

    [inputContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewContainer.mas_top); //with is an optional semantic filler
        make.left.equalTo(viewContainer.mas_left);
        make.right.equalTo(viewContainer.mas_right);

        make.height.greaterThanOrEqualTo(@120);
    }];

    // setup multiplyButton
    self.multiplyButton = [[UIMultiplyButton alloc] init];
    [inputContainer addSubview:self.multiplyButton];

    [self.multiplyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputContainer.mas_top); //with is an optional semantic filler
        make.right.equalTo(inputContainer.mas_right);
        make.height.mas_equalTo(120);
        make.width.mas_equalTo(120);
    }];

    // setup firstField and secondField
    self.firstField = [[UINumberField alloc] init];
    [inputContainer addSubview:self.firstField];

    [self.firstField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.equalTo(inputContainer);
        make.right.equalTo(self.multiplyButton.mas_left).with.offset(-20);
    }];

    self.secondField = [[UINumberField alloc] init];
    [inputContainer addSubview:self.secondField];

    [self.secondField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.bottom.equalTo(inputContainer);
        make.right.equalTo(self.multiplyButton.mas_left).with.offset(-20);
    }];

    // setup resultLabel
    self.resultLabel = [[UINumberResult alloc] init];
    [self.view addSubview:self.resultLabel];

    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(inputContainer.mas_bottom).with.offset(padding.top * 2); //with is an optional semantic filler
        make.right.and.left.equalTo(viewContainer);
        make.height.equalTo(@50);
    }];
}

- (void)setupSignals
{
    RAC(self.multiplyButton, enabled) = [RACSignal
            combineLatest:@[
                    self.firstField.rac_textSignal,
                    self.secondField.rac_textSignal,
            ]
           reduce:^(NSString *fieldOne, NSString *fieldTwo) {
               return @([fieldOne length] > 0 && [fieldTwo length] > 0);
           }
    ];

    RACSignal *operandsSignal = [[RACSignal
            combineLatest:@[
                    self.firstField.rac_textSignal,
                    self.secondField.rac_textSignal,
            ]]
            reduceEach:^id(NSString *string1, NSString *string2) {
                return RACTuplePack(@([string1 floatValue]), @([string2 floatValue]));
            }
    ];

    RACSignal *resultSignal = [[[operandsSignal
            sample:[self.multiplyButton rac_signalForControlEvents:UIControlEventTouchUpInside]]
            reduceEach:^id(NSNumber *multiplicand, NSNumber *multiplier) {
                return @([multiplicand floatValue] * [multiplier floatValue]);
            }]
            map:^id(NSNumber *result) {
                return [result stringValue];
            }
    ];

    RACSignal *clearSignal = [RACSignal
            merge:@[[self.firstField.rac_textSignal distinctUntilChanged],
                    [self.secondField.rac_textSignal distinctUntilChanged]]
    ];

    resultSignal = [resultSignal
            merge:[clearSignal
                    mapReplace:@""]
    ];

    RAC(self.resultLabel, text) = resultSignal;
}

@end