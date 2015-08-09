//
//  PlaylistHeaderView.h
//  CloudDJ
//
//  Created by Dulio Denis on 8/9/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

@import UIKit;
#import "PlaylistItem.h"

@interface PlaylistHeaderView : UICollectionReusableView

@property (nonatomic, weak) IBOutlet UIImageView *blurredImageView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *songLabel;
@property (nonatomic, weak) IBOutlet UILabel *artistLabel;

- (void)setPlaylistItem:(id<PlaylistItem>)playlistItem animated:(BOOL)animated;

@end
