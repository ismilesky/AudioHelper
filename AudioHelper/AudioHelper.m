//
//  AudioHelper.m
//  AudioHelper
//
//  Created by FelixKung on 16/9/21.
//  Copyright © 2016年 FelixKung. All rights reserved.
//

#import "AudioHelper.h"

static AudioHelper *instance = nil;

@implementation AudioHelper

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
    });
    return instance;
}

+ (void)musicCropInputPath:(NSString *)inputPath outputPath:(NSString *)outputPath withStartTime:(NSString *)sTime andEndTime:(NSString *)eTime completedBlock:(void (^)())completeBlock failedBlock:(void (^)(NSError *, AVAssetExportSessionStatus))failedBlock {
    
    // 1.创建AVURLAsset对象（继承了AVAsset）
    NSURL *songURL = [NSURL fileURLWithPath:inputPath];
    AVURLAsset *songAsset = [AVURLAsset URLAssetWithURL:songURL options:nil];
   
    // 2.创建音频文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:outputPath]) {
        [[NSFileManager defaultManager] removeItemAtPath:outputPath error:nil];
    }
    NSURL *exportURL = [NSURL fileURLWithPath:outputPath];
    NSError *assetError = nil;
    if (assetError) {
        NSLog (@"error: %@", assetError);
        return;
    }
    
    //  3.创建音频输出会话
    AVAssetExportSession *exportSession = [AVAssetExportSession exportSessionWithAsset:songAsset presetName:AVAssetExportPresetAppleM4A];
    // 4.设置音频截取时间区域
    CMTime startTime = CMTimeMake([sTime floatValue], 1);
    CMTime endTime = CMTimeMake([eTime floatValue], 1);
    CMTimeRange exportTimeRange = CMTimeRangeFromTimeToTime(startTime, endTime);
    exportSession.outputURL = exportURL;
    exportSession.outputFileType = AVFileTypeAppleM4A; // 输出格式
    exportSession.timeRange = exportTimeRange;
    exportSession.shouldOptimizeForNetworkUse = YES;
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        if (AVAssetExportSessionStatusCompleted == exportSession.status) {
            completeBlock();
        }else {
            NSLog(@"-- exportSession->error : %@",exportSession.error);
            failedBlock(exportSession.error, exportSession.status);
        }
    }];
}

@end
