//
//  AQCapture.m
//  MyInsight_Swift
//
//  Created by SongMenglong on 2019/2/22.
//  Copyright © 2019 SongMengLong. All rights reserved.
//

#import "AQCapture.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

#define QUEUE_BUFFER_SIZE 3      //输出音频队列缓冲个数
#define kDefaultBufferDurationSeconds 0.06      //调整这个值使得录音的缓冲区大小为960,实际会小于或等于960,需要处理小于960的情况
#define kDefaultSampleRate 8000      //定义采样率为8000

static BOOL isRecording = NO;

@interface AQCapture()
{
    AudioQueueRef _audioQueue;      //输出音频播放队列
    AudioStreamBasicDescription _recordFormat;
    AudioQueueBufferRef _audioBuffers[QUEUE_BUFFER_SIZE];      //输出音频缓存
}
@property (nonatomic, assign) BOOL isRecording;

@end

@implementation AQCapture

- (instancetype)init {
    self = [super init];
    if (self) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];//PlayAndRecord
        [[AVAudioSession sharedInstance] setActive:YES error:nil];//如果录音时同时需要播放媒体，那么必须加上这两行代码
        
        memset(&_recordFormat, 0, sizeof(_recordFormat));
        _recordFormat.mSampleRate = kDefaultSampleRate;
        _recordFormat.mChannelsPerFrame = 1;
        _recordFormat.mFormatID = kAudioFormatLinearPCM;
        _recordFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
        _recordFormat.mBitsPerChannel = 16;
        _recordFormat.mBytesPerPacket = _recordFormat.mBytesPerFrame = (_recordFormat.mBitsPerChannel / 8) * _recordFormat.mChannelsPerFrame;
        _recordFormat.mFramesPerPacket = 1;
        //初始化音频输入队列
        AudioQueueNewInput(&_recordFormat, inputBufferHandler, (__bridge void *)(self), NULL, NULL, 0, &_audioQueue);
        //计算估算的缓存区大小
        int frames = (int)ceil(kDefaultBufferDurationSeconds * _recordFormat.mSampleRate);
        int bufferByteSize = frames * _recordFormat.mBytesPerFrame;
        NSLog(@"缓存区大小%d",bufferByteSize);
        //创建缓冲器
        for (int i = 0; i < QUEUE_BUFFER_SIZE; i++){
            AudioQueueAllocateBuffer(_audioQueue, bufferByteSize, &_audioBuffers[i]);
            AudioQueueEnqueueBuffer(_audioQueue, _audioBuffers[i], 0, NULL);
        }
    }
    return self;
}

void inputBufferHandler(void *inUserData, AudioQueueRef inAQ, AudioQueueBufferRef inBuffer, const AudioTimeStamp *inStartTime,UInt32 inNumPackets, const AudioStreamPacketDescription *inPacketDesc) {
    
    NSLog(@"回调函数.... ");
    if (inNumPackets > 0) {
        //AQCapture *recorder = (__bridge AQCapture*)inUserData;
        //[recorder processAudioBuffer:inBuffer withQueue:inAQ];
        
        [[AQCapture new] processAudioBuffer:inBuffer withQueue:inAQ];
    }
    if (isRecording) {
        AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
    }
}

- (void)processAudioBuffer:(AudioQueueBufferRef)audioQueueBufferRef withQueue:(AudioQueueRef)audioQueueRef {
//    NSMutableData *data = [NSMutableData dataWithBytes:audioQueueBufferRef->mAudioData length:audioQueueBufferRef->mAudioDataByteSize];
//    if (data.length < 960) { //处理长度小于960的情况,此处是补00
//        Byte byte[] = {0x00};
//        NSData *zeroData = [[NSData alloc] initWithBytes:byte length:1];
//        for (NSUInteger i = data.length; i < 960; i++) {
//            [data appendData:zeroData];
//        }
//    }
//    //    NSLog(@"%@",data);
//    [self.delegate returnData:data];
}

- (void)startRecord
{
    // 开始录音
    AudioQueueStart(_audioQueue, NULL);
    isRecording = YES;
}

- (void)stopRecord
{
    if (isRecording)
    {
        isRecording = NO;
        //停止录音队列和移除缓冲区,以及关闭session，这里无需考虑成功与否
        AudioQueueStop(_audioQueue, true);
        //移除缓冲区,true代表立即结束录制，false代表将缓冲区处理完再结束
        AudioQueueDispose(_audioQueue, true);
    }
    //    NSLog(@"停止录制");
}

- (void)dealloc {
    _audioQueue = nil;
}




@end

