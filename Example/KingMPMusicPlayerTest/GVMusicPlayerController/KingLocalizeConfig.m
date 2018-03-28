//
//  KingLocalizeConfig.m
//  KingMPMusicPlayerTest
//
//  Created by J on 2017/9/4.
//  Copyright © 2017年 J. All rights reserved.
//

#import "KingLocalizeConfig.h"
#define KCachePath [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingFormat:@"/audioCaches"]
#define FILEMANAGER [NSFileManager defaultManager]
@interface KingLocalizeConfig()
@property(nonatomic,retain)MPMediaItem *item;

@end
@implementation KingLocalizeConfig
-(void)setAssest:(AVURLAsset *)assest
{
    _assest=assest;
}
-(void)setFileURL:(NSURL *)fileURL
{
    _fileURL=fileURL;
}
-(void)setItem:(MPMediaItem *)item
{
    _item=item;
    [self hasLive:KCachePath];
    NSString *exportFile = [KCachePath stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.m4a",_item.title]];

    BOOL isDirectory=YES;
    BOOL isExists=[FILEMANAGER fileExistsAtPath:exportFile isDirectory:&isDirectory];
    if (isExists&&!isDirectory) {
        [FILEMANAGER removeItemAtPath:exportFile error:nil];
    }
    
    self.fileURL=[NSURL fileURLWithPath:exportFile];
}


-(void (^)(AVURLAsset *))KingLocalizeConfigAssest{

    return ^(AVURLAsset *asset){
        self.assest=asset;
        
    };
}
-(void (^)(MPMediaItem *))KingLocalizeConfigMediaItem
{
    return ^(MPMediaItem *item){
        self.item=item;
    };
}


-(BOOL)hasLive:(NSString *)path
{
    if (![FILEMANAGER fileExistsAtPath:path])
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return NO;
}



@end
