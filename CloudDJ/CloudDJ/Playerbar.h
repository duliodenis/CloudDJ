//
//  Playerbar.h
//  CloudDJ
//
//  Created by Dulio Denis on 8/3/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

@import UIKit;

@protocol PlayerbarDelegate;

IB_DESIGNABLE
@interface Playerbar : UIToolbar

@property (nonatomic, assign) IBInspectable CGFloat spacing;
@property (nonatomic, weak) IBOutlet id<PlayerbarDelegate> playerbarDelegate;

@end 

@protocol PlayerbarDelegate <NSObject>

- (void)playerbarPreviousTrack:(Playerbar *)playerbar;
- (void)playerbarNextTrack:(Playerbar *)playerbar;
- (void)playerbarPlayPause:(Playerbar *)playerbar;

@end