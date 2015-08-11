//
//  PlaylistDataSource.h
//  CloudDJ
//
//  Created by Dulio Denis on 8/7/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

@import UIKit;
#import "PlaylistHeaderView.h"

@interface PlaylistDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic) NSArray *items;
@property (nonatomic, assign) NSInteger currentTrackIndex;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) PlaylistHeaderView *playlistHeaderView;

@end
