//
//  PlaylistDataSource.h
//  CloudDJ
//
//  Created by Dulio Denis on 8/7/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

@import UIKit;

@interface PlaylistDataSource : NSObject <UICollectionViewDataSource>

@property (nonatomic) NSArray *items;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end
