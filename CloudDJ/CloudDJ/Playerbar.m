//
//  Playerbar.m
//  CloudDJ
//
//  Created by Dulio Denis on 8/3/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "Playerbar.h"
#import "UIButton+BackgroundColorForState.h"


@interface Playerbar()

@property (nonatomic) UIBarButtonItem *playButton;

@end


@implementation Playerbar


#pragma mark - Initializers


- (void)setEnabled:(BOOL)enabled {
    _enabled = enabled;
    
    for (UIBarButtonItem *item in self.items) {
        item.enabled = enabled;
    }
}


- (void)setPlayButtonState:(BOOL)isPlaying {
    UIImage *image = nil;
    UIImage *highlightedImage = nil;
    
    if (isPlaying) {
        image = [self templateImageNamed:@"1242-pause-toolbar"];
        highlightedImage = [self templateImageNamed:@"1242-pause-selected"];
    } else {
        image = [self templateImageNamed:@"1241-play-toolbar"];
        highlightedImage = [self templateImageNamed:@"1241-play-toolbar-selected"];
    }
    
    UIBarButtonItem *playButtonItem = [self playButton];
    UIButton *playButton = (UIButton *)playButtonItem.customView;
    [playButton setImage:image forState:UIControlStateNormal];
    [playButton setImage:highlightedImage forState:UIControlStateHighlighted];
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
    UIBarButtonItem *previousButton = [self setupPreviousButton];
    UIBarButtonItem *playButton = [self setupPlayButton];
    UIBarButtonItem *nextButton = [self setupNextButton];
    
    self.items = @[previousButton,
                   playButton,
                   nextButton
                   ];
    
    // In order to use AutoLayout we need UIViews from the buttons
    UIView *b1 = previousButton.customView;
    UIView *b2 = playButton.customView;
    UIView *b3 = nextButton.customView;
    
    // horizontal constraints: buttons equally spaced
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[b1]-[b2(==b1)]-[b3(==b1)]-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:NSDictionaryOfVariableBindings(b1,b2,b3)];
    // vertical constraints
    for (UIView *b in @[b1, b2, b3]) {
        // for testing the autolayout borders
        // b.backgroundColor = [UIColor yellowColor];
        NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[b]-(0)-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:NSDictionaryOfVariableBindings(b)];
        constraints = [constraints arrayByAddingObjectsFromArray:verticalConstraints];
    }
    
    [NSLayoutConstraint activateConstraints:constraints];
    
    for (UIBarButtonItem *item in self.items) {
        item.enabled = self.enabled;
    }
}


#pragma mark - Button Helper Methods


- (UIImage *)templateImageNamed:(NSString *)name {
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    
    UIImage *image = [UIImage imageNamed:name
                                inBundle:bundle
           compatibleWithTraitCollection:self.traitCollection];
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
}


- (UIBarButtonItem *)buttonWithImageNamed:(NSString *)imageName target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *imageNormalState = [self templateImageNamed:imageName];
    UIImage *imageSelectedState = [self templateImageNamed:[NSString stringWithFormat:@"%@-selected",imageName]];
    
    [button addTarget:target
               action:action
     forControlEvents:UIControlEventTouchUpInside];
    
    [button setImage:imageNormalState   forState:UIControlStateNormal];
    [button setImage:imageSelectedState forState:UIControlStateHighlighted];
    
    // Use the new UIButton Category to set the playbar button's highlighted color
    [button setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.3] forState:UIControlStateHighlighted];

    button.translatesAutoresizingMaskIntoConstraints = NO;
    

    return [[UIBarButtonItem alloc] initWithCustomView:button];
}


- (UIBarButtonItem *)setupPreviousButton {
    return [self buttonWithImageNamed:@"1247-skip-back-toolbar"
                               target:self
                               action:@selector(skipBack:)];
}


- (UIBarButtonItem *)setupPlayButton {
    if (!self.playButton) {
        self.playButton = [self buttonWithImageNamed:@"1241-play-toolbar"
                                              target:self
                                              action:@selector(playPause:)];
    }
    return self.playButton;
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
#if TARGET_IPHONE_SIMULATOR
    static BOOL isPlaying = NO;
    [self setPlayButtonState:isPlaying];
    isPlaying = !isPlaying;
#else
    [self.playerbarDelegate playerbarPlayPause:self];
#endif
}

@end
