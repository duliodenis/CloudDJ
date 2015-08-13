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
#import "PlaylistHeaderView.h"


@interface ViewController () <MPMediaPickerControllerDelegate>

@property (nonatomic) MPMediaItemCollection *playlist;
@property (nonatomic) MPMusicPlayerController *player;
@property (nonatomic) UIBarButtonItem *playButton;

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet Playerbar *playerBar;
@property (nonatomic, weak) IBOutlet UIView *headerContainerView;
@property (nonatomic) IBOutlet PlaylistDataSource *playlistDataSource;
@end

@implementation ViewController


#pragma mark - View Lifecycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    self.player = [[MPMusicPlayerController alloc] init];
    
    // Place the collection view slightly under the Navbar
    self.collectionView.contentInset = UIEdgeInsetsMake(-64, 0, 44, 0);
    
    // Set-up CollectionView Header to display playing song
    UINib *headerNib = [UINib nibWithNibName:@"PlaylistHeaderView"
                                      bundle:nil];
    NSArray *objects = [headerNib instantiateWithOwner:self
                                              options:nil];
    
    PlaylistHeaderView *header = [objects firstObject];
    [self.headerContainerView addSubview:header];
    
#if TARGET_IPHONE_SIMULATOR // In Simulator Add Sample Playlist Items
    NSArray *items = @[
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"inutero.jpg"] artist:@"Nirvana" title:@"Heart-Shaped Box"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"inrainbows.jpg"] artist:@"Radiohead" title:@"House of Cards"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"aenima.jpg"] artist:@"Tool" title:@"Forty-six and Two"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"meddle.jpg"] artist:@"Pink Floyd" title:@"Echoes"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"andjustice.jpg"] artist:@"Metallica" title:@"One"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"bloodsugar.jpg"] artist:@"Red Hot Chili Peppers" title:@"Give it Away"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"inrainbows.jpg"] artist:@"Radiohead" title:@"House of Cards"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"ten.jpg"] artist:@"Pearl Jam" title:@"Ten"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"darkside.jpg"] artist:@"Pink Floyd" title:@"The Great Gig in the Sky"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"dummy.jpg"] artist:@"Portishead" title:@"Strangers"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"suburbs.jpg"] artist:@"Arcade Fire" title:@"Modern Man"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"housesoftheholy.jpg"] artist:@"Led Zeppelin" title:@"No Quarter"],
                       [[SamplePlaylistItem alloc] initWithImage:[UIImage imageNamed:@"kindofblue.jpg"] artist:@"Miles Davis" title:@"Freddie Freeloader"]
                       ];
    
    self.playlistDataSource.items = items;
    self.playerBar.enabled = YES;
#endif
    
    // set the playlist header view to the header subview
    self.playlistDataSource.playlistHeaderView = header;
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


- (void)playPause {
    if (self.player.playbackState == MPMusicPlaybackStatePlaying) {
        [self.player pause];
    } else {
        [self.player play];
    }
}


- (IBAction)playPauseToggle:(id)sender {
    self.playButton = sender;
    [self playPause];
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
    
    self.playerBar.enabled = YES;
    
    // Console Output
    int index = 1;
    for (MPMediaItem *item in self.playlist.items) {
        NSLog(@"%d) %@ - %@", index++, item.artist, item.title);
    }
    
    [self.player setQueueWithItemCollection:self.playlist];
    self.playlistDataSource.items = self.playlist.items;
    
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


#pragma mark - Playerbar Delegate Methods

- (void)playerbarPreviousTrack:(Playerbar *)playerbar {
    self.playlistDataSource.currentTrackIndex -= 1;
}


- (void)playerbarNextTrack:(Playerbar *)playerbar {
    self.playlistDataSource.currentTrackIndex += 1;
}


- (void)playerbarPlayPause:(Playerbar *)playerbar {
    [self playPause];
}

@end
