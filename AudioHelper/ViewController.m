//
//  ViewController.m
//  AudioHelper
//
//  Created by FelixKung on 16/9/21.
//  Copyright © 2016年 FelixKung. All rights reserved.
//

#import "ViewController.h"
#import "AudioHelper.h"

#define kCachesPath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]

#define kMusicEditPath [kCachesPath stringByAppendingPathComponent:@"MusicEditFloder"]
#define kTempPath      [kCachesPath stringByAppendingPathComponent:@"TempFloder"]

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    if (![fileMgr fileExistsAtPath:kMusicEditPath]) {
        [fileMgr createDirectoryAtPath:kMusicEditPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"kMusicEditPath：-->  %@",kMusicEditPath);
    if (![fileMgr fileExistsAtPath:kTempPath]) {
        [fileMgr createDirectoryAtPath:kTempPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"kTempPath: --->>>  %@",kTempPath);
}

- (IBAction)onCutMusicBtnTap:(UIButton *)sender {

    NSString *path = [NSString stringWithFormat:@"%@/%@",kMusicEditPath,@"edit.m4a"];
    [AudioHelper musicCropInputPath:@"/Users/kongfei/Desktop/actor.mp3" outputPath:path withStartTime:@"0" andEndTime:@"100" completedBlock:^{
        
        NSString *tempPath = [NSString stringWithFormat:@"%@/%@",kTempPath,@"edit.mp3"];
        NSFileManager *fileMgr = [NSFileManager defaultManager];
        if ([fileMgr fileExistsAtPath:tempPath]) {
            [fileMgr removeItemAtPath:tempPath error:nil];
        }
        NSError *error;
        [fileMgr moveItemAtPath:path toPath:tempPath error:&error];
        NSLog(@"%@",error.localizedDescription);
        
    } failedBlock:^(NSError *error, AVAssetExportSessionStatus status) {
        NSLog(@" %@ --- %ld",error.localizedDescription, (long)status);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
