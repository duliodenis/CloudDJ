//
//  PlaylistDataSource.m
//  CloudDJ
//
//  Created by Dulio Denis on 8/7/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "PlaylistDataSource.h"
#import "PlaylistItem.h"
#import "PlaylistItemCollectionViewCell.h"

@implementation PlaylistDataSource

- (void)setItems:(NSArray *)items {
    _items = items;
    [self.collectionView reloadData];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.items.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PlaylistItemCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell"
                                                                            forIndexPath:indexPath];
    
    id<PlaylistItem> playlistItem = self.items[indexPath.row];
    cell.imageView.image = playlistItem.image;
    cell.artistLabel.text = playlistItem.artist;
    cell.songLabel.text = playlistItem.song;
     
    return cell;
}

@end
