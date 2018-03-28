//
//  KingIpodLibLocalizeTool.h
//  KingMPMusicPlayerTest
//
//  Created by J on 2017/9/4.
//  Copyright © 2017年 J. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KingLocalizeConfig.h"
@interface KingIpodLibLocalizeTool : NSObject

+(void)localizeIpodWithConfig:(KingLocalizeConfig *(^)(KingLocalizeConfig *config))config andSuccess:(void(^)(NSURL *url))success;


@end
