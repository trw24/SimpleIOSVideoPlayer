//
//  VideoPlayerModel.m
//  SimpleVideoPlayer
//
//  Created by troy on 5/7/14.
//  Copyright (c) 2014 Troy W. All rights reserved.
//

#import "VideoPlayerModel.h"


@interface VideoPlayerModel()

-(void) videoPlaybackDidFinish:(NSNotification *)notification;
@property (nonatomic, strong) MPMoviePlayerController * moviePlayerController;


@end




@implementation VideoPlayerModel


+(VideoPlayerModel *) getVideoPlayerModel
{
    static VideoPlayerModel * _videoPlayerModel;
    
    if (_videoPlayerModel == nil)
    {
        _videoPlayerModel = [[VideoPlayerModel alloc] init];
    }
    
    return (_videoPlayerModel);
}


-(BOOL) videoIsPlaying
{
    // If (video is playing) or (video is paused),
    // then this method returns TRUE
    
    MPMoviePlaybackState playbackState = self.moviePlayerController.playbackState;
    
    if (playbackState == MPMoviePlaybackStatePlaying ||
        playbackState == MPMoviePlaybackStatePaused )
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}


-(void) playOneVideo:(NSString *)fileName ofType:(NSString *)fileType fromView:(UIView *)parentsView
{
    NSString *videoPath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType inDirectory:@"Videos" ];
    
    if (videoPath.length == 0)
    {
        NSLog(@"playOneVideo: video not found.");
        return;
    }
    
    NSURL *videoURL = [NSURL fileURLWithPath:videoPath];
    
    self.moviePlayerController = [[MPMoviePlayerController alloc] initWithContentURL: videoURL];
    [self.moviePlayerController prepareToPlay];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(videoPlaybackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.moviePlayerController];
    
    [self.moviePlayerController setFullscreen:YES animated:YES];
    [self.moviePlayerController setScalingMode:MPMovieScalingModeAspectFit];
    [self.moviePlayerController setControlStyle:MPMovieControlStyleFullscreen];
    [[self.moviePlayerController view] setFrame:parentsView.bounds];
    [parentsView addSubview:[self.moviePlayerController view]];
    [self.moviePlayerController play];
}


-(void) videoPlaybackDidFinish:(NSNotification *)notification
{
    self.moviePlayerController = [notification object];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerPlaybackDidFinishNotification
                                                  object:self.moviePlayerController];
    
    [self.moviePlayerController stop];
    [UIViewController attemptRotationToDeviceOrientation];
    // Hide status bar before main view re-appears
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.moviePlayerController.view removeFromSuperview];
}


@end









