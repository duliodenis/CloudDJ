//
//  SamplePlaylistItem.h
//  CloudDJ
//
//  Created by Dulio Denis on 8/8/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

@import Foundation;
@import UIKit;
#import "PlaylistItem.h"

@interface SamplePlaylistItem : NSObject <PlaylistItem>
@property (nonatomic, readonly) UIImage *image;     // album artwork
@property (nonatomic, readonly) NSString *artist;   // artist name
@property (nonatomic, readonly) NSString *title;     // media file

- (instancetype)initWithImage:(UIImage *)image
                       artist:(NSString *)artist
                         title:(NSString *)title;

@end
