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
        [UIView animateWithDuration:0.4 animations:updateBlock];
    } else {
        updateBlock();
    }
}

@end
