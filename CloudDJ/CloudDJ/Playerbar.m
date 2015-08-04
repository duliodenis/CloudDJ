//
//  Playerbar.m
//  CloudDJ
//
//  Created by Dulio Denis on 8/3/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "Playerbar.h"

@implementation Playerbar


#pragma mark - Initializers

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self initializePlayerbar];
    }
    
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initializePlayerbar];
    }
    
    return self;
}


- (void)initializePlayerbar {
    self.spacing = 30;
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                target:nil
                                                                                action:nil];
    [fixedSpace setWidth:self.spacing];
    
    UIBarButtonItem *previousButton = [self setupPreviousButton];
    UIBarButtonItem *playButton = [self setupPlayButton];
    UIBarButtonItem *nextButton = [self setupNextButton];
    
    self.items = @[flexibleSpace,
                   previousButton,
                   fixedSpace,
                   playButton,
                   fixedSpace,
                   nextButton,
                   flexibleSpace
                   ];
}


#pragma mark - Button Helper Methods

- (UIBarButtonItem *)buttonWithImageNamed:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *imageNormalState = [UIImage imageNamed:imageName];
    UIImage *imageSelectedState = [UIImage imageNamed:[NSString stringWithFormat:@"%@-selected",imageName]];
    [button setImage:[imageNormalState imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
            forState:UIControlStateNormal];
    [button setImage:[imageSelectedState imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
            forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, imageNormalState.size.width *2, imageNormalState.size.height *2);

    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


- (UIBarButtonItem *)setupPreviousButton {
    return [self buttonWithImageNamed:@"1247-skip-back-toolbar"];
}

- (UIBarButtonItem *)setupPlayButton {
    return [self buttonWithImageNamed:@"1241-play-toolbar"];
}

- (UIBarButtonItem *)setupNextButton {
    return [self buttonWithImageNamed:@"1248-skip-ahead-toolbar"];
}

@end
