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


- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    
    for (UIBarButtonItem *item in self.items) {
        item.enabled = enabled;
    }
}


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
    
    for (UIBarButtonItem *item in self.items) {
        item.enabled = self.enabled;
    }
}


#pragma mark - Button Helper Methods

- (UIBarButtonItem *)buttonWithImageNamed:(NSString *)imageName target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    
    UIImage *imageNormalState = [UIImage imageNamed:imageName
                                           inBundle:bundle
                      compatibleWithTraitCollection:self.traitCollection];
    UIImage *imageSelectedState = [UIImage imageNamed:[NSString stringWithFormat:@"%@-selected",imageName]
                                             inBundle:bundle
                        compatibleWithTraitCollection:self.traitCollection];
    
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:[imageNormalState imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
            forState:UIControlStateNormal];
    [button setImage:[imageSelectedState imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
            forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, imageNormalState.size.width *2, imageNormalState.size.height *2);

    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


- (UIBarButtonItem *)setupPreviousButton {
    return [self buttonWithImageNamed:@"1247-skip-back-toolbar"
                               target:self
                               action:@selector(skipBack:)];
}


- (UIBarButtonItem *)setupPlayButton {
    return [self buttonWithImageNamed:@"1241-play-toolbar"
                               target:self
                               action:@selector(playPause:)];
}


- (UIBarButtonItem *)setupNextButton {
    return [self buttonWithImageNamed:@"1248-skip-ahead-toolbar"
                               target:self
                               action:@selector(skipForward:)];
}


#pragma mark - Interface Builder Lifecycle Methods

- (void)prepareForInterfaceBuilder {
    UIView *previous = [[self setupPreviousButton] customView];
    UIView *play = [[self setupPlayButton] customView];
    UIView *next = [[self setupNextButton] customView];
    
    CGFloat widthOfControl = self.frame.size.width;
    CGFloat heightOfControl = self.frame.size.height;
    
    CGFloat buttonWidth = play.frame.size.width;
    CGFloat buttonHeight = play.frame.size.height;
    
    CGFloat y = (heightOfControl - buttonHeight) / 2.0f;
    CGFloat x = ((widthOfControl - 3 * buttonWidth) - (2 * self.spacing)) / 2.0f;
    
    NSArray *views = @[ previous, play, next ];
    for (UIView *view in views) {
        CGRect rect = CGRectMake(x, y, buttonWidth, buttonHeight);
        view.frame = rect;
        
        [self addSubview:view];
        x += buttonWidth + self.spacing;
    }
}


#pragma mark - Playbar Action Methods: (back, next, play/pause)

- (void)skipBack:(id)sender {
    [self.playerbarDelegate playerbarPreviousTrack:self];
}


- (void)skipForward:(id)sender {
    [self.playerbarDelegate playerbarNextTrack:self];
}


- (void)playPause:(id)sender {
    [self.playerbarDelegate playerbarPlayPause:self];
}

@end
