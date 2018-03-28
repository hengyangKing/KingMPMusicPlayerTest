//
//  KingIpodLibLocalizeTool.m
//  KingMPMusicPlayerTest
//
//  Created by J on 2017/9/4.
//  Copyright © 2017年 J. All rights reserved.
//

#import "KingIpodLibLocalizeTool.h"

@implementation KingIpodLibLocalizeTool
+(void)localizeIpodWithConfig:(KingLocalizeConfig *(^)(KingLocalizeConfig *config))config andSuccess:(void(^)(NSURL *url))success
{
    if (config) {
        KingLocalizeConfig *tempConfig = config([[KingLocalizeConfig alloc]init]);
        if (tempConfig) {
            
            AVAssetExportSession *exporter = [[AVAssetExportSession alloc]initWithAsset: tempConfig.assest presetName: AVAssetExportPresetAppleM4A];
            NSLog (@"created exporter. supportedFileTypes: %@", exporter.supportedFileTypes);
            exporter.outputFileType = @"com.apple.m4a-audio";
            exporter.outputURL = tempConfig.fileURL;
            
            [exporter exportAsynchronouslyWithCompletionHandler:^{
                int exportStatus = exporter.status;
                switch (exportStatus) {
                    case AVAssetExportSessionStatusFailed: {
                        // log error to text view
                        NSError *exportError = exporter.error;
                        NSLog (@"AVAssetExportSessionStatusFailed: %@",
                               exportError);
                        break;
                    }
                    case AVAssetExportSessionStatusCompleted: {
                        NSLog (@"AVAssetExportSessionStatusCompleted");
                        if (success) {
                            success(exporter.outputURL);
                        }
                        break;
                    }
                    case AVAssetExportSessionStatusUnknown: {
                        NSLog (@"AVAssetExportSessionStatusUnknown"); break;}
                    case AVAssetExportSessionStatusExporting: {
                        NSLog (@"AVAssetExportSessionStatusExporting"); break;}
                    case AVAssetExportSessionStatusCancelled: {
                        NSLog (@"AVAssetExportSessionStatusCancelled"); break;}
                    case AVAssetExportSessionStatusWaiting: {
                        NSLog (@"AVAssetExportSessionStatusWaiting"); break;}
                    default: { NSLog (@"didn't get export status"); break;}
                };
            }];
        }
    }
}

@end
