//
//  SamplePlaylistItem.m
//  CloudDJ
//
//  Created by Dulio Denis on 8/8/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import "SamplePlaylistItem.h"

@implementation SamplePlaylistItem

- (instancetype)initWithImage:(UIImage *)image artist:(NSString *)artist song:(NSString *)song {
    if (self = [super init]) {
        _image = image;
        _artist = artist;
        _song = song;
    }
    return self;
}

@end
