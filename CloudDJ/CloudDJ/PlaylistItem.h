//
//  PlaylistItem.h
//  CloudDJ
//
//  Created by Dulio Denis on 8/7/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PlaylistItem <NSObject>

@property (nonatomic, readonly) UIImage *image;     // album artwork
@property (nonatomic, readonly) NSString *artist;   // artist name
@property (nonatomic, readonly) NSString *title;     // media file 

@end
