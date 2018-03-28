//
//  KingLocalizeConfig.h
//  KingMPMusicPlayerTest
//
//  Created by J on 2017/9/4.
//  Copyright © 2017年 J. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
@interface KingLocalizeConfig : NSObject
@property(nonatomic,retain,readonly)AVURLAsset *assest;

@property(nonatomic,retain,readonly)NSURL *fileURL;

@property(nonatomic,copy,readonly)void (^KingLocalizeConfigAssest)(AVURLAsset *assest);

@property(nonatomic,copy,readonly)void (^KingLocalizeConfigMediaItem)(MPMediaItem *item);



@end
