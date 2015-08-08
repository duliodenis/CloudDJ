//
//  PlaylistItemCollectionViewCell.h
//  CloudDJ
//
//  Created by Dulio Denis on 8/8/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

@import UIKit;

@interface PlaylistItemCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *artistLabel;
@property (nonatomic, weak) IBOutlet UILabel *songLabel;


@end
