//
//  ViewController.m
//  SimpleVideoPlayer
//
//  Created by troy on 5/7/14.
//  Copyright (c) 2014 Troy W. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) CGRect rectPortrait;
@property (nonatomic) CGRect rectLandscape;

@end



@implementation ViewController



- (void)viewDidAppear:(BOOL)animated
{

    self.rectPortrait = self.view.superview.frame;
    
    // For landscape, swap WIDTH and HEIGHT
    CGRect tempRect = CGRectMake(self.view.superview.frame.origin.x, self.view.superview.frame.origin.y,
                                 self.view.superview.frame.size.height, self.view.superview.frame.size.width);
    
    self.rectLandscape = tempRect;
}


- (IBAction)playVideoButton:(UIButton *)sender {
    
    // in all cases, set view.frame equal to superView.frame
    // self.view.frame = self.view.superview.frame;
    
    // Get current orientation
    UIApplication * thisApplication = [UIApplication sharedApplication];
    UIInterfaceOrientation currentOrientation = [thisApplication  statusBarOrientation];

    // "Frame" values are Portrait in all cases
    self.view.frame = self.rectPortrait;
    
    if (UIInterfaceOrientationIsPortrait(currentOrientation))
    {
        // Portrait
        self.view.bounds = self.rectPortrait;
    }
    else
    {
        // Landscape,
        self.view.bounds = self.rectLandscape;
    }
    
    // [self.view.superview layoutSubviews];
    [self.view.superview layoutIfNeeded];
    
    VideoPlayerModel * myVideoPlayerModel = [VideoPlayerModel getVideoPlayerModel];
    [myVideoPlayerModel playOneVideo:@"fishmovie" ofType:@"mov" fromView:self.view];
}


- (NSUInteger)supportedInterfaceOrientations
{
    // If video is NOT playing, allow (auto-detect) rotation in all 4 x orientations.
    // If video IS playing, limit rotation to 180-degrees.
    
    // Get current orientation
    UIApplication * thisApplication = [UIApplication sharedApplication];
    UIInterfaceOrientation currentOrientation = [thisApplication  statusBarOrientation];
    
    // Test to see if video is playing
    VideoPlayerModel * videoPlayerModel = [VideoPlayerModel getVideoPlayerModel];
    if ([videoPlayerModel videoIsPlaying] == TRUE)
    {
        // Since video is playing,
        // only allow rotation of 180-degrees (i.e. "matching orientation")
        if (UIInterfaceOrientationIsPortrait(currentOrientation))
        {
            return (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskPortraitUpsideDown);
        }
        else
        {
            return (UIInterfaceOrientationMaskLandscape);
        }
    }
    else
    {
        // Since video is NOT playing,
        // allow rotation to all orientations
        return UIInterfaceOrientationMaskAll;
    }
}


- (BOOL)shouldAutorotate
{
    return YES;
}



@end





