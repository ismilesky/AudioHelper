## AudioHelper
指定时间段，截取某一段音频数据

## Usage
导入`AudioHelper.h` 头文件

```
/**
  *  设置起始时间导出音频
  * @param inputPath    源路径
  * @param outputPath   输出路径
  * @param sTime        开始时间
  * @param eTime        结束时间
  * @param completeBlock 成功回调
  * @para  failedBlock   失败回调
 */
+ (void)musicCropInputPath:(NSString *)inputPath outputPath:(NSString *)outputPath 
                              withStartTime:(NSString *)sTime andEndTime:(NSString *)eTime 
                              completedBlock:(void (^)())completeBlock 
                              failedBlock:(void(^)(NSError *error,AVAssetExportSessionStatus status))failedBlock;

```

Example:

```
    NSString *path = [NSString stringWithFormat:@"%@/%@",kMusicEditPath,@"edit.m4a"];
    [AudioHelper musicCropInputPath:@"mp3数据" outputPath:path withStartTime:@"0" andEndTime:@"100" completedBlock:^{
        NSLog(@" %@ ---> SUCCESS");
    } failedBlock:^(NSError *error, AVAssetExportSessionStatus status) {
        NSLog(@" %@ --- %ld",error.localizedDescription, (long)status);
    }];
```
