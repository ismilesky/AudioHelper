//
//  AudioHelper.h
//  AudioHelper
//
//  Created by FelixKung on 16/9/21.
//  Copyright © 2016年 FelixKung. All rights reserved.
//

/**
 
 AudioHelper是一个音频的管理类
 */

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioHelper : NSObject

+ (instancetype)shareInstance;

/**
  *  设置起始时间导出音频
  * @param inputPath    源路径
  * @param outputPath   输出路径
  * @param sTime        开始时间
  * @param eTime        结束时间
  * @param completeBlock 成功回调
  * @para  failedBlock   失败回调
 */
+ (void)musicCropInputPath:(NSString *)inputPath outputPath:(NSString *)outputPath withStartTime:(NSString *)sTime andEndTime:(NSString *)eTime completedBlock:(void (^)())completeBlock failedBlock:(void(^)(NSError *error,AVAssetExportSessionStatus status))failedBlock;

@end
