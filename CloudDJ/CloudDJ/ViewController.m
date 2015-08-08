//
//  ViewController.m
//  CloudDJ
//
//  Created by Dulio Denis on 7/28/15.
//  Copyright (c) 2015 Dulio Denis. All rights reserved.
//

@import MediaPlayer;
#import "ViewController.h"
#import "PlaylistDataSource.h"
#import "SamplePlaylistItem.h"


@interface ViewController () <MPMediaPickerControllerDelegate>
@property (nonatomic) MPMediaItemCollection *playlist;
@property (nonatomic) MPMusicPlayerController *player;
@property (weak, nonatomic) IBOutlet UIToolbar *playerBar;
@property (nonatomic) UIBarButtonItem *playButton;
@property (nonatomic) IBOutlet PlaylistDataSource *playlistDataSource;
@end

@implementation ViewController


#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.player = [[MPMusicPlayerController alloc] init];
    
#if TARGET_IPHONE_SIMULATOR // In Simulator Add Sample Playlist Items
    NSArray *items = @[
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"inutero.jpg"] artist:@"Nirvana" song:@"Heart-Shaped Box"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"inrainbows.jpg"] artist:@"Radiohead" song:@"House of Cards"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"aenima.jpg"] artist:@"Tool" song:@"Forty-six and Two"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"meddle.jpg"] artist:@"Pink Floyd" song:@"Echoes"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"andjustice.jpg"] artist:@"Metallica" song:@"One"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"bloodsugar.jpg"] artist:@"Red Hot Chili Peppers" song:@"Give it Away"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"inrainbows.jpg"] artist:@"Radiohead" song:@"House of Cards"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"ten.jpg"] artist:@"Pearl Jam" song:@"Ten"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"darkside.jpg"] artist:@"Pink Floyd" song:@"The Great Gig in the Sky"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"dummy.jpg"] artist:@"Portishead" song:@"Strangers"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"suburbs.jpg"] artist:@"Arcade Fire" song:@"Modern Man"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"housesoftheholy.jpg"] artist:@"Led Zeppelin" song:@"No Quarter"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"kindofblue.jpg"] artist:@"Miles Davis" song:@"Freddie Freeloader"]
                       ];
    
    self.playlistDataSource.items = items;
#endif
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
