//
//  PlaylistHeaderView.m
//  CloudDJ
//
//  Created by Dulio Denis on 8/9/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "PlaylistHeaderView.h"

@implementation PlaylistHeaderView

- (void)setPlaylistItem:(id<PlaylistItem>)playlistItem animated:(BOOL)animated {
    void (^updateBlock)() = ^ {
        self.artistLabel.text = [playlistItem artist];
        self.songLabel.text = [playlistItem song];
        self.imageView.image = [playlistItem image];
        self.blurredImageView.image = [playlistItem image];
    };
    
    if (animated) {
        //  transitionWithView is a little choppy
        /* [UIView transitionWithView:self.imageView
                          duration:0.8
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            updateBlock();
                        } completion:^(BOOL finished) {
                            
                        }]; */
        
        // instead take a snapshot of the current state and overlay it
        UIView *previousState = [self snapshotViewAfterScreenUpdates:NO];
        [self addSubview:previousState];
        updateBlock(); // then update in the background
        
        // and animate the foreground away
        [UIView animateWithDuration:0.3
                         animations:^{
                             previousState.alpha = 0;
                         } completion:^(BOOL finished) {
                             [previousState removeFromSuperview];
                         }];
    } else {
        updateBlock();
    }
}

@end
