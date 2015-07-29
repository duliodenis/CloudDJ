//
//  ViewController.m
//  CloudDJ
//
//  Created by Dulio Denis on 7/28/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

@import MediaPlayer;
#import "ViewController.h"


@interface ViewController () <MPMediaPickerControllerDelegate>
@property (nonatomic) MPMediaItemCollection *playlist;
@property (nonatomic) MPMusicPlayerController *player;
@property (weak, nonatomic) IBOutlet UIToolbar *playerBar;
@property (nonatomic) UIBarButtonItem *playButton;
@end

@implementation ViewController


#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.player = [[MPMusicPlayerController alloc] init];
}


#pragma mark - Player Actions

- (IBAction)addMusic:(id)sender {
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mediaPicker.prompt = @"Add music to your playlist";
    mediaPicker.showsCloudItems = YES;
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES;
    [self presentViewController:mediaPicker animated:YES completion:nil];
}


- (IBAction)playPauseToggle:(id)sender {
    self.playButton = sender;
    if (self.player.playbackState == MPMusicPlaybackStatePlaying) {
        [self.player pause];
    } else {
        [self.player play];
    }
    [self setPlayButtonItemForPlaybackState:self.player.playbackState];
}


- (void)setPlayButtonItemForPlaybackState:(MPMusicPlaybackState)playbackState {
    NSMutableArray *barButtonItems = [self.playerBar.items mutableCopy];
    NSUInteger index = [barButtonItems indexOfObjectIdenticalTo:self.playButton];
    
    [barButtonItems removeObjectAtIndex:index];
    [barButtonItems insertObject:[self playButtonItemForPlaybackState:playbackState]
                         atIndex:index];
    [self.playerBar setItems:barButtonItems];
}


- (UIBarButtonItem *)playButtonItemForPlaybackState:(MPMusicPlaybackState)playbackState {
    UIBarButtonSystemItem systemItem;
    if (playbackState == MPMusicPlaybackStatePlaying) {
        // if playing set the button to pause
        systemItem = UIBarButtonSystemItemPause;
    } else {
        // otherwise set the button to play
        systemItem = UIBarButtonSystemItemPlay;
    }
    
    UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:systemItem
                                                                                target:self
                                                                                action:@selector(playPauseToggle:)];
    return buttonItem;
}


#pragma mark - MPMediaPickerController Delegate Methods

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection {
    
    if (!self.playlist) {
        self.playlist = mediaItemCollection;
    } else {
        NSMutableArray *items = [NSMutableArray arrayWithCapacity:self.playlist.count + mediaItemCollection.count];
        [items addObject:self.playlist];
        [items addObject:mediaItemCollection];
        MPMediaItemCollection *collection = [MPMediaItemCollection collectionWithItems:items];
        self.playlist = collection;
    }
    
    // Console Output
    int index = 1;
    for (MPMediaItem *item in self.playlist.items) {
        NSLog(@"%d) %@ - %@", index++, item.artist, item.title);
    }
    
    [self.player setQueueWithItemCollection:self.playlist];
    if (self.player.playbackState != MPMusicPlaybackStatePlaying) {
        [self.player play];
    }
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
