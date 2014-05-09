//
//  VideoPlayerModel.h
//  SimpleVideoPlayer
//
//  Created by troy on 5/7/14.
//  Copyright (c) 2014 Troy W. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>


@interface VideoPlayerModel : NSObject


// Class method to get the shared model
+(VideoPlayerModel *) getVideoPlayerModel;


// Public Instance Methods
-(void) playOneVideo:(NSString *)fileName ofType:(NSString *)fileType fromView:(UIView *)parentsView;
-(BOOL) videoIsPlaying;



@end



