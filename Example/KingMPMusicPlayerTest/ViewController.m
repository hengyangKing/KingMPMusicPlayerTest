//
//  ViewController.m
//  KingMPMusicPlayerTest
//
//  Created by J on 2017/6/26.
//  Copyright © 2017年 J. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CLMediaPicker/CLMediaPicker.h>
#import "GVMusicPlayerController.h"
@interface ViewController ()<MPMediaPickerControllerDelegate,CLMediaPickerDelegate,GVMusicPlayerControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *songLabel;

@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cover;

@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[GVMusicPlayerController sharedInstance] addDelegate:self];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [[GVMusicPlayerController sharedInstance] removeDelegate:self];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}
- (IBAction)Picker:(id)sender {
    MPMediaPickerController *mpController = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    mpController.delegate = self;
    mpController.prompt = @"Add songs to play";
    mpController.allowsPickingMultipleItems = YES;
    
    [self presentViewController:mpController animated:YES completion:nil];
}
- (IBAction)CLPicker:(id)sender {
    
    CLMediaPicker *picker = [[CLMediaPicker alloc] init];
    picker.mediaTypes = CLMediaPickerAll;
    picker.delegate = self;
    picker.allowsPickingMultipleItems = YES;
    picker.showsCloudItems = NO;
    picker.isModal = YES;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:picker];
    [self presentViewController:navController animated:YES completion:nil];
    
    
}

#pragma mark delegate 
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [[GVMusicPlayerController sharedInstance] setQueueWithItemCollection:mediaItemCollection];
    [[GVMusicPlayerController sharedInstance] play];
    
}
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)clMediaPicker:(CLMediaPicker *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    [mediaPicker dismissViewControllerAnimated:YES completion:nil];
    [[GVMusicPlayerController sharedInstance] setQueueWithItemCollection:mediaItemCollection];
    [[GVMusicPlayerController sharedInstance] play];

    
}

- (void)clMediaPickerDidCancel:(CLMediaPicker *)mediaPicker
{
    [self dismissViewControllerAnimated:NO completion:nil];
}



- (void)musicPlayer:(GVMusicPlayerController *)musicPlayer trackDidChange:(MPMediaItem *)nowPlayingItem previousTrack:(MPMediaItem *)previousTrack
{
    // Labels
    self.songLabel.text = [nowPlayingItem valueForProperty:MPMediaItemPropertyTitle];
    self.artistLabel.text = [nowPlayingItem valueForProperty:MPMediaItemPropertyArtist];
    
    // Artwork
    MPMediaItemArtwork *artwork = [nowPlayingItem valueForProperty:MPMediaItemPropertyArtwork];
    if (artwork != nil) {
        self.cover.image = [artwork imageWithSize:self.cover.frame.size];
    }
}
- (void)musicPlayer:(GVMusicPlayerController *)musicPlayer endOfQueueReached:(MPMediaItem *)lastTrack
{
    
}
- (void)musicPlayer:(GVMusicPlayerController *)musicPlayer playbackStateChanged:(MPMusicPlaybackState)playbackState previousPlaybackState:(MPMusicPlaybackState)previousPlaybackState{


}
- (void)musicPlayer:(GVMusicPlayerController *)musicPlayer volumeChanged:(float)volume
{
    
}
@end
