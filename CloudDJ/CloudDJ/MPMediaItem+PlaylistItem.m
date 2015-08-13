//
//  MPMediaItem+PlaylistItem.m
//  CloudDJ
//
//  Created by Dulio Denis on 8/13/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "MPMediaItem+PlaylistItem.h"

@implementation MPMediaItem (PlaylistItem)

- (UIImage *)image {
    return [self.artwork imageWithSize:CGSizeMake(600, 600)];
}

@end
