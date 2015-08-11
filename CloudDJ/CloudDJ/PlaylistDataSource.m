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
#import "PlaylistHeaderView.h"

@implementation PlaylistDataSource

- (void)setCurrentTrackIndex:(NSInteger)currentTrackIndex {
    _currentTrackIndex = currentTrackIndex;
    
    if (_currentTrackIndex >= (NSInteger)self.items.count) {
        _currentTrackIndex = 0;
    } else if (_currentTrackIndex < 0) {
        _currentTrackIndex = self.items.count - 1;
    }
    
    // trigger a collection view layout update
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
}


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

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        PlaylistHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                        withReuseIdentifier:@"header" forIndexPath:indexPath];
        [header setPlaylistItem:self.items[self.currentTrackIndex] animated:YES];
        return header;
    }
    
    return nil;
}

@end
